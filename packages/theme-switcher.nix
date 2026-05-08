_top: {
  perSystem = { pkgs, ... }: let
    theme = "$XDG_CONFIG_HOME/ghostty/themes/custom";
    noctalia-colors = "$XDG_CONFIG_HOME/noctalia/colors.json";
  in {
    packages.theme-switcher = pkgs.writers.writePython3Bin "theme-switcher" {} ''
      import re


      def get_colors():
          json = open("${noctalia-colors}")
          lines = json.split("\n")
          json.close()
          return map(lambda x: re.search("#[0-9a-fA-F]{6}", x).group(), lines[1:-1])


      with open("${theme}", "w") as f:
          f.write("""
            background = #303446
            foreground = #c6d0f5
            cursor-color = #f2d5cf
            cursor-text = #c6d0f5
            """)
          for i, color in enumerate(get_colors()):
              f.write(f"palette = {i}={color}")
    '';
  };
}
