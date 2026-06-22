---------------------------
--- Global Window Rules ---
---------------------------

hl.window_rule({
    match = { class = "^(wl-mirror)$" },
    monitor = os.getenv("PROJECTOR_PORT"),
    fullscreen = true
})

hl.window_rule({
    match = { class = "^(clipse)$" },
    float = true,
    center = true,
    size = "70% 70%"
})

hl.window_rule({
    match = { class = "^(yazi)$" },
    float = true,
    center = true,
    size = "70% 70%"
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move = "20 monitor_h-120",
    float = true,
})
