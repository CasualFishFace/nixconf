{ inputs, ... }: {
  flake.nixosModules.users = args@{ config, lib, ... }: let
    inherit (config.users) blacklist;
    allowed-user = u: (blacklist == null || !(builtins.elem u blacklist));
  in {
    options.users = {
      blacklist = lib.mkOption {
        description = ''
          A custom blacklist option to disallow specific users from a system config.
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
