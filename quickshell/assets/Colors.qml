import QtQuick
pragma Singleton

QtObject {

    // Primary
    property color primary: "#4a5c92"
    property color on_primary: "#ffffff"
    property color primary_container: "#dbe1ff"
    property color on_primary_container: "#00174a"
    property color inverse_primary: "#b4c5ff"

    property color primary_fixed: "#dbe1ff"
    property color primary_fixed_dim: "#b4c5ff"
    property color on_primary_fixed: "#00174a"
    property color on_primary_fixed_variant: "#324478"

    // Secondary
    property color secondary: "#585e72"
    property color on_secondary: "#ffffff"
    property color secondary_container: "#dde1f9"
    property color on_secondary_container: "#161b2c"

    property color secondary_fixed: "#dde1f9"
    property color secondary_fixed_dim: "#c1c6dd"
    property color on_secondary_fixed: "#161b2c"
    property color on_secondary_fixed_variant: "#414659"

    // Tertiary
    property color tertiary: "#745471"
    property color on_tertiary: "#ffffff"
    property color tertiary_container: "#ffd6f8"
    property color on_tertiary_container: "#2b122b"

    property color tertiary_fixed: "#ffd6f8"
    property color tertiary_fixed_dim: "#e2bbdc"
    property color on_tertiary_fixed: "#2b122b"
    property color on_tertiary_fixed_variant: "#5a3d58"

    // Error
    property color error: "#ba1a1a"
    property color on_error: "#ffffff"
    property color error_container: "#ffdad6"
    property color on_error_container: "#410002"

    // Surface / Background
    property color surface:         "#121318"
    property color on_surface:      "#e3e2e9"
    property color surface_container:           "#1e1f25"
    property color surface_container_low:       "#1a1b21"
    property color surface_container_lowest:    "#0d0e13"
    property color surface_container_high:      "#292a2f"
    property color surface_container_highest:   "#33343a"
    property color surface_dim:      "#121318"
    property color surface_bright:   "#38393f"
    property color surface_variant:  "#45464f"
    property color inverse_surface:          "#e3e2e9"
    property color inverse_on_surface:       "#2f3036"

    // Others
    property color outline:           "#8f909a"
    property color outline_variant:   "#45464f"
    property color background:        "#121318"
    property color on_background:     "#e3e2e9"
    property color shadow:            "#000000"
    property color scrim:             "#000000"
    property color source_color:      "#5974c2"
}
