#!/usr/bin/env bash

symlink () {
    target=$1
    destination=$HOME/$1

    if [ ! -d $target ]; then
        echo "Target directory $target/ doesn't exist"
        exit 1
    fi

    if [ ! -d "$destination"/ ]; then
        echo "Destination directory $destination/ doesn't exist"
        echo "Creating directory $destination/"
        mkdir -p $destination
    fi

    ln -sfr $1/* $HOME/$1/
}

symlink .config
symlink .local/share/themes
symlink .local/share/icons
symlink Pictures

ln -sfr bin $HOME

