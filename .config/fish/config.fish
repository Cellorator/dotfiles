if status is-interactive
end

fish_add_path ~/bin
fish_add_path ~/.cargo/bin

set -gx EDITOR nvim
set -gx QT_QPA_PLATFORMTHEME qt5ct
set -gx BAT_THEME "base16-256"

# Startup
echo
set -gx PF_INFO "ascii title os kernel pkgs memory uptime "
pfetch

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

# Zellij abbreviations
abbr -a zl zellij
abbr -a zla zellij attach
abbr -a zll zellij list-sessions

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

starship init fish | source
zoxide init fish | source
fzf --fish | source

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/admin/.ghcup/bin $PATH # ghcup-env
