# Se non è interattivo, esci
if not status is-interactive
    exit
end


# === Avvia Hyprland automaticamente su TTY1 ===
if test -z "$DISPLAY"; and test "$XDG_VTNR" -eq 1
    exec Hyprland
end


# === Alias ===
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias ..='cd ..'
alias ....='cd ../..'

alias gs='git status'
alias ga='git add'
alias gc='git commit'


#          ╭──────────────────────────────────────────────────────────╮
#          │                  Rimpiazzo per sudo !!                   │
#          ╰──────────────────────────────────────────────────────────╯

function sudo --description "Replacement for Bash 'sudo !!'"
    
    if test "$argv" = !!
        echo sudo $history[1]
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end


# === Prompt personalizzato ===
# In Fish, PS1 non viene usato. Puoi impostare un prompt base così:
# function fish_prompt
#     echo -n (whoami)'@'(hostname -s)' '(prompt_pwd)'$ '
# end
# Tuttavia tu usi Starship (vedi sotto), quindi non serve modificarlo.

# === Variabili d'ambiente ===
set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim
set -gx SUDO_EDITOR /usr/bin/nvim
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml


set -U fish_greeting ""
# === Starship prompt ===
starship init fish | source
