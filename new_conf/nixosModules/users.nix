{ inputs, ... }: {
  flake.nixosModules.users = args@{ config, lib, ... }: let
    inherit (config.users) blacklist whitelist;

    allowed-user = u:
      (blacklist == null || !(builtins.elem u blacklist))
      && (whitelist == null || (builtins.elem u whitelist));
  in {
    options.users = {
      blacklist = lib.mkOption {
        description = ''
          A custom blacklist option to disallow specific users from a system config.
        '';

        default = null;
        type = with lib.types; nullOr (listOf str);
      };

      whitelist = lib.mkOption {
        description = ''
          A custom whitelist option to allow only specific users onto a system config.
        '';

        default = null;
        type = with lib.types; nullOr (listOf str);
      };
    };
    
    config.users.users = let
      tree = inputs.import-tree ./../users;
      tree-imports = map (f: f args) tree.imports;
      user-files = (inputs.nixpkgs.lib.mergeAttrsList tree-imports).imports;
      all-users = inputs.nixpkgs.lib.mergeAttrsList (map import user-files);
    in lib.filterAttrs (n: _: allowed-user n) all-users;
  };
}
