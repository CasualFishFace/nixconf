_top: {
  perSystem = { pkgs, ... }: {
    packages.theme-switcher = pkgs.writers.writePython3Bin "theme-switcher" {} ''
      import re
      import os


      HOME = os.environ["HOME"]


      def get_colors():
          json = open(f"{HOME}/.config/noctalia/colors.json", "r")
          lines = json.readlines()
          json.close()
          res = map(lambda line: re.search("#[0-9a-fA-F]{6}", line), lines[1:-1])
          res = filter(lambda x: x is not None, res)
          return map(lambda x: x.group(), res)


      try:
          os.mkdir(f"{HOME}/.config/ghostty/themes")
      except FileExistsError:
          pass

      with open(f"{HOME}/.config/ghostty/themes/custom", "w") as f:
          f.write("""
            background = #303446
            foreground = #c6d0f5
            cursor-color = #f2d5cf
            cursor-text = #c6d0f5
            """)
          for i, color in enumerate(get_colors()):
              f.write(f"palette = {i}={color}\n")
    '';
  };
}
