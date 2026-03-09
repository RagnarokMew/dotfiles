pragma Singleton

import QtQuick

import "themes"

QtObject {
    readonly property var theme: CatppuccinMacchiato {}

    // --- Palette Mapping ---
    readonly property color rosewater:  theme.rosewater
    readonly property color flamingo:   theme.flamingo
    readonly property color pink:       theme.pink
    readonly property color mauve:      theme.mauve
    readonly property color red:        theme.red
    readonly property color maroon:     theme.maroon
    readonly property color peach:      theme.peach
    readonly property color yellow:     theme.yellow
    readonly property color green:      theme.green
    readonly property color teal:       theme.teal
    readonly property color sky:        theme.sky
    readonly property color sapphire:   theme.sapphire
    readonly property color blue:       theme.blue
    readonly property color lavender:   theme.lavender
    readonly property color text:       theme.text
    readonly property color subtext1:   theme.subtext1
    readonly property color subtext0:   theme.subtext0
    readonly property color overlay2:   theme.overlay2
    readonly property color overlay1:   theme.overlay1
    readonly property color overlay0:   theme.overlay0
    readonly property color surface2:   theme.surface2
    readonly property color surface1:   theme.surface1
    readonly property color surface0:   theme.surface0
    readonly property color base:       theme.base
    readonly property color mantle:     theme.mantle
    readonly property color crust:      theme.crust
    
    // Standard utility colors
    readonly property color white:      "#ffffff"
    readonly property color black:      "#000000"

    // --- Main Colors ---
    // shade(@crust, 0.5) equivalent - making crust 50% darker
    readonly property color shadow:     Qt.darker(crust, 1.5) 
    readonly property color mainFg:     text
    readonly property color mainBg:     crust
    readonly property color mainBr:     text

    readonly property color activeBg:   overlay2
    readonly property color activeFg:   crust

    readonly property color hoverBg:    surface0
    // alpha(@text, 0.75) equivalent
    readonly property color hoverFg:    Qt.rgba(text.r, text.g, text.b, 0.75)

    // --- Module Colors ---
    readonly property color moduleFg:             text
    readonly property color workspaces:           mantle
    readonly property color temperature:          mantle
    readonly property color memory:               base
    readonly property color cpu:                  surface0
    readonly property color distroFg:             black
    readonly property color distroBg:             overlay2
    readonly property color time:                 surface0
    readonly property color date:                 base
    readonly property color tray:                 mantle
    readonly property color pulseaudio:           mantle
    readonly property color backlight:            base
    readonly property color battery:              surface0
    readonly property color power:                overlay2

    // --- State Colors ---
    readonly property color warning:     yellow
    readonly property color critical:    red
    readonly property color charging:    green
}
