if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

fish_add_path ~/bin
fish_add_path ~/.cargo/bin

set -gx EDITOR nvim
set -gx QT_QPA_PLATFORMTHEME qt5ct

# Useful abbreviations and aliases
abbr -a cl clear
abbr -a cd z
abbr vim nvim
abbr vi nvim

alias ls="eza -1 --icons"
alias la="eza -la --icons"
alias tree="eza -Ta --icons"
alias cat="bat"
alias cat="bat"

# Git abbreviations
abbr -a gi git init
abbr -a gcl git clone
abbr -a ga git add
abbr -a ga. git add .
abbr -a --set-cursor gc git commit -m \"%\"
abbr -a gs git status
abbr -a gd git diff
abbr -a gl git log --oneline
abbr -a gp git push

# Yadm abbreviations
abbr -a ya yadm add
abbr -a ya. yadm add .
abbr -a --set-cursor yc yadm commit -m \"%\"
abbr -a ys yadm status
abbr -a yd yadm diff
abbr -a yl yadm log --oneline
abbr -a yp yadm push

# Autostart zellij
if set -q ZELLIJ
else
  zellij
end
set -gx ZELLIJ_AUTO_ATTACH true

starship init fish | source
zoxide init fish | source
fzf --fish | source
