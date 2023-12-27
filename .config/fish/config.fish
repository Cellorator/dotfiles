if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path ~/bin
fish_add_path ~/.cargo/bin

set -Ux EDITOR nvim
set -Ux QT_QPA_PLATFORMTHEME qt5ct

starship init fish | source
zoxide init fish | source
set -x BAT_THEME ansi

# Useful abbreviations and aliases
abbr -a vim nvim
abbr -a cat bat
abbr -a cd z

alias ls="eza -1 --icons"
alias la="eza -la --icons"
alias tree="eza -Ta --icons"

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

alias backup-prism="rsync -azvP --delete /home/admin/.local/share/PrismLauncher/instances/ /run/media/admin/main-32gb/MinecraftMods/InstanceBackups/"
alias restore-prism="rsync -avzP --delete '/run/media/admin/main-32gb/MinecraftMods/InstanceBackups/' /home/admin/.local/share/PrismLauncher/instances/"

set fish_greeting
