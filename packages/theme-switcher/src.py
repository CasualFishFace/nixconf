# pyright: reportOptionalMemberAccess=false

import re
import subprocess as sp
import os


HOME = os.environ["HOME"]


def get_colors():
    json = open(f"{HOME}/.config/noctalia/colors.json", "r")
    lines = json.readlines()
    json.close()
    res = map(lambda line: re.search("#[0-9a-fA-F]{6}", line), lines[1:-1])
    res = filter(lambda x: x is not None, res)
    return map(lambda x: x.group(), res)


def make_palette():
    raw = list(get_colors())
    palette: list[str] = ["" for _ in range(16)]
    palette[0] = raw[0]
    palette[1] = raw[11]
    palette[2] = raw[10]
    palette[3] = raw[12]
    palette[4] = raw[2]
    palette[5] = raw[8]
    palette[6] = raw[13]
    palette[7] = raw[9]
    palette[8] = raw[6]
    palette[9] = raw[3]
    palette[10] = raw[4]
    palette[11] = raw[1]
    palette[12] = raw[5]
    palette[13] = raw[14]
    palette[14] = raw[7]
    palette[15] = raw[15]
    print("\n".join([f"{i} = {color}" for i, color in enumerate(palette)]))
    return palette


def ghostty(colors: list[str]):
    try:
        os.mkdir(f"{HOME}/.config/ghostty/themes")
    except FileExistsError:
        pass

    with open(f"{HOME}/.config/ghostty/themes/custom", "w") as f:
        _ = f.write(f"background = {colors[5]}\n")
        _ = f.write(f"foreground = {colors[4]}\n")
        _ = f.write("cursor-color = #f2d5cf\n")
        _ = f.write("cursor-text = #c6d0f5\n")
        for i, color in enumerate(get_colors()):
            _ = f.write(f"palette = {i}={color}\n")


def reload_themes():
    _ = sp.run(["pkill", "-SIGUSR2", "ghostty"])


colors = make_palette()
ghostty(colors)
reload_themes()
