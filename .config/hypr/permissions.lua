hl.config({
    ecosystem = {
        enforce_permissions = (os.getenv("HYPR_PERMS") == "true"),
    },
})

-- NOTE:
-- needs: hyprland-guiutils
-- If using Nix none of these will work since you need to use Regex
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/

hl.permission({ binary = "/usr/(lib|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/bin/grim", type = "screencopy", mode = "allow" })
hl.permission({ binary = "usr/bin/hyprpicker", type = "screencopy", mode = "allow" })
