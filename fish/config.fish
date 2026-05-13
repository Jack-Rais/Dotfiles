# Se non è interattivo, esci
if not status is-interactive
    exit
end


# === Alias ===
alias ls='ls --color=auto'
alias grep='grep --color=auto'

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

set -gx JAVA_HOME /usr/lib/jvm/java-17-openjdk
set -gx ANDROID_HOME /opt/android-sdk

set -gx PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin
set -gx PATH $PATH $ANDROID_HOME/platform-tools
set -gx PATH $PATH $ANDROID_HOME/emulator

set -gx PATH $PATH ~/.cargo/bin/


set -U fish_greeting ""
# === Starship prompt ===
starship init fish | source
