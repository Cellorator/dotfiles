if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path ~/bin
fish_add_path ~/.cargo/bin

set -Ux EDITOR nvim
set -Ux QT_QPA_PLATFORMTHEME qt5ct

starship init fish | source
zoxide init fish | source

# Useful abbreviations and aliases
abbr -a cl clear

alias ls="eza -1 --icons"
alias la="eza -la --icons"
alias tree="eza -Ta --icons"
alias cat="bat"
alias cd="z"
alias cat="bat"
alias vim="nvim"

# Git abbreviations
abbr -a gi git init
abbr -a gc git clone
abbr -a ga git add
abbr -a --set-cursor gc git commit -m \"%\"
abbr -a gs git status
abbr -a gd git diff
abbr -a gl git log
abbr -a gp git push

# Yadm abbreviations
abbr -a ya yadm add
abbr -a --set-cursor yc yadm commit -m \"%\"
abbr -a ys yadm status
abbr -a yd yadm diff
abbr -a yp yadm push

set fish_greeting
