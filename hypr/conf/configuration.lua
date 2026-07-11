
hl.config({

    --          ╭─────────────────────────────────────────────────────────╮
    --          │                         General                         │
    --          ╰─────────────────────────────────────────────────────────╯

    general = {
        gaps_in = 2,
        gaps_out = 4,

        border_size = 0
    },


    --          ╭─────────────────────────────────────────────────────────╮
    --          │                       Decorations                       │
    --          ╰─────────────────────────────────────────────────────────╯

    decoration = {
        rounding = 16,
        rounding_power = 2,

        blur = {
            enabled = false
        },

        shadow = {
            enabled = false
        },

    },

    animations = {
        enabled = false
    },


    --          ╭─────────────────────────────────────────────────────────╮
    --          │                          Input                          │
    --          ╰─────────────────────────────────────────────────────────╯

    input = {
        kb_layout = "it",
        follow_mouse = 1,

        touchpad = {
            natural_scroll = true,
        }
    },

    cursor = {
        warp_on_change_workspace = 1,
    },

    --          ╭─────────────────────────────────────────────────────────╮
    --          │                         Layout                          │
    --          ╰─────────────────────────────────────────────────────────╯

    dwindle = {
        preserve_split = true
    },


    --          ╭─────────────────────────────────────────────────────────╮
    --          │                          Misc                           │
    --          ╰─────────────────────────────────────────────────────────╯

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        initial_workspace_tracking = 1
    },


    --          ╭─────────────────────────────────────────────────────────╮
    --          │                       Additional                        │
    --          ╰─────────────────────────────────────────────────────────╯

    ecosystem = {
        no_donation_nag = true
    }

})



hl.workspace_rule({ workspace = "1", persistent = true })
hl.workspace_rule({ workspace = "2", persistent = true })
hl.workspace_rule({ workspace = "3", persistent = true })
hl.workspace_rule({ workspace = "4", persistent = true })
hl.workspace_rule({ workspace = "5", persistent = true })
hl.workspace_rule({ workspace = "6", persistent = true })
hl.workspace_rule({ workspace = "7", persistent = true })
hl.workspace_rule({ workspace = "8", persistent = true })
