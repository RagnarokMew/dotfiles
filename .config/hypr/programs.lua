----------------
--- Programs ---
----------------

local terminal = "kitty"

local programs = {
    terminal = terminal,
    menu = "walker",
    menuBacked = "elephant",
    fileManager = terminal .. "--class yazi -e 'yazi'",
    clipboard = {
        persist = "wl-clip-persist --clipboard regular",
        manager = "clipse -listen",
        run = terminal .. "--class clipse -e 'clipse'",
    },
    screenshot = {
        full =
        "mkdir -p ~/Pictures/Screenshots/$(date +'%Y')/$(date +'%m') && grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +'%Y-%m-%d-%H%M%S').png",
        select =
        "mkdir -p ~/Pictures/Screenshots/$(date +'%Y')/$(date +'%m') && grim ~/Pictures/Screenshots/$(date +'%Y-%m-%d-%H%M%S').png",
    },
    project = "~/.config/hypr/scripts/mirror_screen.sh",
    bar = "waybar",
    notifManager = "dunst",
    wallpaperManager = {
        daemon = "awww-daemon",
    },
    colorPicker = "hyprpicker",
}
return programs
