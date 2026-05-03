{ inputs, ... }: {
  flake.nixosModules.users = { config, lib, ... }: let
    inherit (config.users) blacklist whitelist;

    allowed-user = u:
      (blacklist == null || !(builtins.elem u blacklist))
      && (whitelist == null || (builtins.elem u whitelist));

    mkUser = name: attrs: if allowed-user name then {
      ${name} = attrs;
    } else {};
  in {
    options.users = {
      blacklist = lib.mkOption {
        default = null;
        description = ''
          A custom blacklist option to disallow specific users from a system config.
        '';
        type = with lib.types; nullOr (listOf str);
      };
      whitelist = lib.mkOption {
        default = null;
        description = ''
          A custom whitelist option to allow only specific users onto a system config.
        '';
        type = with lib.types; nullOr (listOf str);
      };
    };
    
    config.users.users = lib.mergeAttrsList (builtins.map (f: f { inherit mkUser; }) [
      (inputs.import-tree ./../users)
    ]);
  };
}
