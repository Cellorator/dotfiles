if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path ~/bin
fish_add_path ~/.cargo/bin

starship init fish | source
zoxide init fish | source
set -x BAT_THEME ansi

# Useful abbreviations and aliases
abbr -a vim nvim
abbr -a cat bat
abbr -a ls eza --icons
abbr -a la eza -la --icons
abbr -a tree eza -Ta --icons
abbr -a cd z

# Git abbreviations
abbr -a gi git init
abbr -a gc git clone
abbr -a ga git add
abbr -a --set-cursor gc git commit -m \"%\"
abbr -a gs git status
abbr -a gl git log
abbr -a gp git push

# Yadm abbreviations
abbr -a ya yadm add
abbr -a --set-cursor yc yadm commit -m \"%\"
abbr -a ys yadm status
abbr -a yp yadm push

alias backup-prism="rsync -azvP --delete /home/admin/.local/share/PrismLauncher/instances/ /run/media/admin/main-32gb/MinecraftMods/InstanceBackups/"
alias restore-prism="rsync -avzP --delete '/run/media/admin/main-32gb/MinecraftMods/InstanceBackups/' /home/admin/.local/share/PrismLauncher/instances/"

set fish_greeting
