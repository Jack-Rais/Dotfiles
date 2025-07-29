import QtQuick
pragma Singleton

QtObject {

    // Primary
    property color primary: "#ffb2bb"
    property color on_primary: "#561d27"
    property color primary_container: "#72333d"
    property color on_primary_container: "#ffd9dd"
    property color inverse_primary: "#8e4954"

    property color primary_fixed: "#ffd9dd"
    property color primary_fixed_dim: "#ffb2bb"
    property color on_primary_fixed: "#3b0714"
    property color on_primary_fixed_variant: "#72333d"

    // Secondary
    property color secondary: "#e5bdc0"
    property color on_secondary: "#43292c"
    property color secondary_container: "#5c3f42"
    property color on_secondary_container: "#ffd9dd"

    property color secondary_fixed: "#ffd9dd"
    property color secondary_fixed_dim: "#e5bdc0"
    property color on_secondary_fixed: "#2c1518"
    property color on_secondary_fixed_variant: "#5c3f42"

    // Tertiary
    property color tertiary: "#e9bf8f"
    property color on_tertiary: "#442b07"
    property color tertiary_container: "#5e411b"
    property color on_tertiary_container: "#ffddb8"

    property color tertiary_fixed: "#ffddb8"
    property color tertiary_fixed_dim: "#e9bf8f"
    property color on_tertiary_fixed: "#2a1700"
    property color on_tertiary_fixed_variant: "#5e411b"

    // Error
    property color error: "#ffb4ab"
    property color on_error: "#690005"
    property color error_container: "#93000a"
    property color on_error_container: "#ffdad6"

    // Surface / Background
    property color surface: "#1a1112"
    property color on_surface: "#f0dedf"
    property color surface_container: "#261d1e"
    property color surface_container_low: "#22191a"
    property color surface_container_lowest: "#140c0d"
    property color surface_container_high: "#312828"
    property color surface_container_highest: "#3d3233"
    property color surface_dim: "#1a1112"
    property color surface_bright: "#413737"
    property color surface_variant: "#524344"
    property color inverse_surface: "#f0dedf"
    property color inverse_on_surface: "#382e2f"

    // Others
    property color outline: "#9f8c8e"
    property color outline_variant: "#524344"
    property color background: "#1a1112"
    property color on_background: "#f0dedf"
    property color shadow: "#000000"
    property color scrim: "#000000"
    property color source_color: "#9d2c45"
}
