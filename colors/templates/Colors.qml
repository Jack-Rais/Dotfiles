import QtQuick
pragma Singleton

QtObject {

    // Primary
    property color primary: "{{ colors.primary.dark.hex }}"
    property color on_primary: "{{ colors.on_primary.dark.hex }}"
    property color primary_container: "{{ colors.primary_container.dark.hex }}"
    property color on_primary_container: "{{ colors.on_primary_container.dark.hex }}"
    property color inverse_primary: "{{ colors.inverse_primary.dark.hex }}"

    property color primary_fixed: "{{ colors.primary_fixed.dark.hex }}"
    property color primary_fixed_dim: "{{ colors.primary_fixed_dim.dark.hex }}"
    property color on_primary_fixed: "{{ colors.on_primary_fixed.dark.hex }}"
    property color on_primary_fixed_variant: "{{ colors.on_primary_fixed_variant.dark.hex }}"

    // Secondary
    property color secondary: "{{ colors.secondary.dark.hex }}"
    property color on_secondary: "{{ colors.on_secondary.dark.hex }}"
    property color secondary_container: "{{ colors.secondary_container.dark.hex }}"
    property color on_secondary_container: "{{ colors.on_secondary_container.dark.hex }}"

    property color secondary_fixed: "{{ colors.secondary_fixed.dark.hex }}"
    property color secondary_fixed_dim: "{{ colors.secondary_fixed_dim.dark.hex }}"
    property color on_secondary_fixed: "{{ colors.on_secondary_fixed.dark.hex }}"
    property color on_secondary_fixed_variant: "{{ colors.on_secondary_fixed_variant.dark.hex }}"

    // Tertiary
    property color tertiary: "{{ colors.tertiary.dark.hex }}"
    property color on_tertiary: "{{ colors.on_tertiary.dark.hex }}"
    property color tertiary_container: "{{ colors.tertiary_container.dark.hex }}"
    property color on_tertiary_container: "{{ colors.on_tertiary_container.dark.hex }}"

    property color tertiary_fixed: "{{ colors.tertiary_fixed.dark.hex }}"
    property color tertiary_fixed_dim: "{{ colors.tertiary_fixed_dim.dark.hex }}"
    property color on_tertiary_fixed: "{{ colors.on_tertiary_fixed.dark.hex }}"
    property color on_tertiary_fixed_variant: "{{ colors.on_tertiary_fixed_variant.dark.hex }}"

    // Error
    property color error: "{{ colors.error.dark.hex }}"
    property color on_error: "{{ colors.on_error.dark.hex }}"
    property color error_container: "{{ colors.error_container.dark.hex }}"
    property color on_error_container: "{{ colors.on_error_container.dark.hex }}"

    // Surface / Background
    property color surface: "{{ colors.surface.dark.hex }}"
    property color on_surface: "{{ colors.on_surface.dark.hex }}"
    property color surface_container: "{{ colors.surface_container.dark.hex }}"
    property color surface_container_low: "{{ colors.surface_container_low.dark.hex }}"
    property color surface_container_lowest: "{{ colors.surface_container_lowest.dark.hex }}"
    property color surface_container_high: "{{ colors.surface_container_high.dark.hex }}"
    property color surface_container_highest: "{{ colors.surface_container_highest.dark.hex }}"
    property color surface_dim: "{{ colors.surface_dim.dark.hex }}"
    property color surface_bright: "{{ colors.surface_bright.dark.hex }}"
    property color surface_variant: "{{ colors.surface_variant.dark.hex }}"
    property color inverse_surface: "{{ colors.inverse_surface.dark.hex }}"
    property color inverse_on_surface: "{{ colors.inverse_on_surface.dark.hex }}"

    // Others
    property color outline: "{{ colors.outline.dark.hex }}"
    property color outline_variant: "{{ colors.outline_variant.dark.hex }}"
    property color background: "{{ colors.background.dark.hex }}"
    property color on_background: "{{ colors.on_background.dark.hex }}"
    property color shadow: "{{ colors.shadow.dark.hex }}"
    property color scrim: "{{ colors.scrim.dark.hex }}"
    property color source_color: "{{ colors.source_color.dark.hex }}"
}
