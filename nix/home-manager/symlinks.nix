{ config, username, ... }:

let
    # toNameValuePair = dir: {
    #     name = dir + ".source";
    #     value = config.lib.file.mkOutOfStoreSymlink "/home/${username}/${dir}";
    # };
    #
    # # Creates sets in the format of { "folder" = config.lib.file.mkOutOfStoreSymlink "path/to/folder"}
    # # Just goes straight to home
    # createLinks = dirs: builtins.listToAttrs (map toNameValuePair dirs);
    #
    # # These ones are self explanatory
    # createXDGConfigHomeLinks = folders: builtins.listToAttrs (map toNameValuePair (map (x: ".config/" + x) folders));
    # createXDGDateHomeLinks = folders: builtins.listToAttrs (map toNameValuePair (map (x: ".local/share/" + x) folders));

    link = folder: {
        source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/dotfiles/${folder}";
    };

in {
    "bin" = link "bin";
    ".config/nvim" = link ".config/nvim";
    ".config/fish" = link ".config/fish";
    ".config/wezterm" = link ".config/wezterm";
    ".config/awesome" = link ".config/awesome";
    ".config/picom" = link ".config/picom";
    ".config/bat" = link ".config/bat";
}


