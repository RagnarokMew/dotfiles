---------------------
--- Laptop Screen ---
---------------------

local output = "eDP-1"
local mode = "highres"
local position = "auto"
local scale = 1.33

hl.monitor({
    output = output,
    mode = mode,
    position = position,
    scale = scale,
})

---------------------------
--- Mirror to Projector ---
---------------------------

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})
