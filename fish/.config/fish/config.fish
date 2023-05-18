if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path ~/bin
fish_add_path ~/.cargo/bin

starship init fish | source
zoxide init fish | source

set -gx EDITOR nvim
set -x BAT_THEME ansi

abbr -a vim nvim
abbr -a car bat
abbr -a ls exa
abbr -a la exa -a
abbr -a cd z

# Git abbreviations
abbr -a gi git init
abbr -a gc git clone
abbr -a ga git add
abbr -a gc git commit
abbr -a gs git status
abbr -a gl git log
abbr -a gp git push

abbr -a --position anywhere fish-conf ~/.config/fish/config.fish

alias backup-prism="rsync -azvP --delete /home/admin/.local/share/PrismLauncher/instances/ /run/media/admin/main-32gb/MinecraftMods/InstanceBackups/"
alias restore-prism="rsync -avzP --delete '/run/media/admin/main-32gb/MinecraftMods/InstanceBackups/' /home/admin/.local/share/PrismLauncher/instances/"
#alias shifttime="~/scripts/shifttime"

set fish_greeting
