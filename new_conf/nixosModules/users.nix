{ inputs, ... }: let
  inherit (inputs.nixpkgs) lib;
in {
  flake.nixosModules.users = { config, ... }: let
    inherit (config.users) blacklist whitelist;

    allowed-user = u:
      (blacklist == null || !(builtins.elem u blacklist))
      && ((builtins.elem u whitelist) || whitelist == null);

    mkUser = name: attrs: lib.mkIf (allowed-user name) {
      users.users.${name} = attrs;
    };
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
    
    config = lib.mergeAttrsList [

      (mkUser "trash-bun" {
        isNormalUser = true;
        description = "foo";
      })

      (mkUser "fishface" {
        isNormalUser = true;
        description = "CasualFishFace";
        extraGroups = [ "networkmanager" "wheel" "video" ];
      })

    ];
  };
}
