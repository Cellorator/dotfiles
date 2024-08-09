{ config, username, ... }:

let
    link = folder: {
        source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/dotfiles/${folder}";
    };

    toNameValuePair = folder: {
        name = folder;
        value = link folder;
    };

    linkHomeFolders = folders: builtins.listToAttrs (map toNameValuePair folders);

    prependStr = str: set: map (x: str + x) set;
in linkHomeFolders [
        "bin"
    ]
