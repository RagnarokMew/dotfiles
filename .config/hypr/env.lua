local envs = {
    MAIN_MONITOR_PORT = "eDP-1", -- Change to your own
    PROJECTOR_PORT = "HDMI-1",   -- Change to your own
    XCURSOR_SIZE = "24",
    HYPRCURSOR_SIZE = "24",
    QT_QPA_PLATFORMTHEME = "qt6ct",
}

for k, v in pairs(envs) do
    hl.env(k, v)
end
