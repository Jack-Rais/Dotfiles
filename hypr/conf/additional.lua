

--          ╭─────────────────────────────────────────────────────────╮
--          │                  Environment Variables                  │
--          ╰─────────────────────────────────────────────────────────╯

-- XDG: identify session type correctly to portals and daemons
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE",    "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Qt: wayland-first with xcb fallback, disable client-side decorations
hl.env("QT_QPA_PLATFORM",                  "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME",             "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- GTK: wayland-first backend, clutter for GNOME apps
hl.env("GDK_BACKEND",     "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")

-- Firefox: explicit wayland mode
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Chromium / Electron: native wayland rendering
hl.env("OZONE_PLATFORM",              "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT","wayland")

-- SDL2: wayland-first (games / SDL apps)
hl.env("SDL_VIDEODRIVER", "wayland")

-- Java: fixes blank/grey windows in AWT apps (IntelliJ, etc.)
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")

-- Cursor: env vars for XWayland and non-GTK apps
hl.env("XCURSOR_THEME", "phinger-cursors-dark")
hl.env("XCURSOR_SIZE",  "24")

-- Hyprcursor (Hyprland's native cursor renderer, preferred over XCURSOR_*)
hl.env("HYPRCURSOR_THEME", "phinger-cursors-dark")
hl.env("HYPRCURSOR_SIZE",  "24")
