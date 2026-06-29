
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
--          │             File manager and system dialogs             │
--          ╰─────────────────────────────────────────────────────────╯

-- xdg-desktop-portal file picker (used across many apps when on Wayland)
hl.window_rule({
    name   = "xdg-file-picker",
    match  = { class = "^xdg-desktop-portal.*" },
    float  = true,
    center = true,
    size   = {800, 600},
})

-- Polkit authentication dialog (password prompts)
hl.window_rule({
    name   = "polkit-dialog",
    match  = { class = "^(polkit-gnome-authentication-agent-1|org.kde.polkit-kde-authentication-agent-1|lxqt-policykit-agent)$" },
    float  = true,
    center = true,
    size   = { 400, 200 },
})
