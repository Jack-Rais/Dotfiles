
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Universal                        │
--          ╰─────────────────────────────────────────────────────────╯

-- Prevent apps from force maximizing themselves
hl.window_rule({
    name  = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Keeps invisible XWayland placeholder windows from stealing focus.
hl.window_rule({
    name        = "fix-xwayland-drags",
    match       = {
        class       = "^$",
        title       = "^$",
        xwayland    = true,
        float       = true,
        fullscreen  = false,
        pin         = false,
    },
    no_focus    = true,
})


--          ╭─────────────────────────────────────────────────────────╮
--          │                         Firefox                         │
--          ╰─────────────────────────────────────────────────────────╯

-- Firefox internal dialogs (permissions, downloads, bookmark save, etc.)
hl.window_rule({
    name   = "firefox-popups",
    match  = { class = "^(firefox|Firefox|firefox-esr)$" },
    float  = true,
    center = true,
    size   = { 400, 600 },
})

-- Firefox extension popups (e.g. uBlock, Bitwarden popout windows)
hl.window_rule({
    name  = "firefox-ext-popup",
    match = {
        class = "^(firefox|Firefox|firefox-esr)$",
        title = "^Extension:.*",
    },
    float  = true,
    center = true,
    size   = { 400, 600 },
})


--          ╭─────────────────────────────────────────────────────────╮
--          │             File manager and system dialogs             │
--          ╰─────────────────────────────────────────────────────────╯

-- Standalone file manager window: tile normally
hl.window_rule({
    name  = "filemanager-tile",
    match = { class = "^(org.gnome.Nautilus|dolphin|thunar|Thunar|nemo|pcmanfm)$" },
    float = false,
})

-- File manager sub-dialogs (properties, permissions, rename, etc.)
hl.window_rule({
    name   = "filemanager-dialogs",
    match  = { class = "^(org.gnome.Nautilus|dolphin|thunar|Thunar|nemo|pcmanfm)$" },
    float  = true,
    center = true,
    size   = { "35%", "50%" },
})

-- xdg-desktop-portal file picker (used across many apps when on Wayland)
hl.window_rule({
    name   = "xdg-file-picker",
    match  = { class = "^xdg-desktop-portal.*" },
    float  = true,
    center = true,
    size   = { "50%", "65%" },
})

-- Polkit authentication dialog (password prompts)
hl.window_rule({
    name   = "polkit-dialog",
    match  = { class = "^(polkit-gnome-authentication-agent-1|org.kde.polkit-kde-authentication-agent-1|lxqt-policykit-agent)$" },
    float  = true,
    center = true,
    size   = { 400, 200 },
})
