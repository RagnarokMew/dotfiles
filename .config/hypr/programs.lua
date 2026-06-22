local programs = {}

----------------
--- Programs ---
----------------

programs.terminal = "kitty"
programs.menu = "walker"
programs.menuBacked = "elephant"
programs.fileManager = programs.terminal .. "--class yazi -e 'yazi'"
programs.clipboard.persist = "wl-clip-persist --clipboard regular"
programs.clipboard.manager = "clipse -listen"
programs.clipboard.run = programs.terminal .. "--class clipse -e 'clipse'"
programs.screenshot.full =
"mkdir -p ~/Pictures/Screenshots/$(date +'%Y')/$(date +'%m') && grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +'%Y-%m-%d-%H%M%S').png"
programs.screenshot.select =
"mkdir -p ~/Pictures/Screenshots/$(date +'%Y')/$(date +'%m') && grim ~/Pictures/Screenshots/$(date +'%Y-%m-%d-%H%M%S').png"
programs.project = "~/.config/hypr/scripts/mirror_screen.sh"
programs.bar = "waybar"
programs.notifManager = "dunst"
programs.wallpaperManager.daemon = "aww-daemon"
programs.colorPicker = "hyprpicker"

return programs
