local g = vim.g
g.mapleader = " "
g.maplocalleader = " "

-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	install = {
		colorscheme = { "gruvbox-material" }
	},
    checker = {
        enabled = true,
        frequency = 86400,
    }
}

require("lazy").setup("plugins", opts)

require("options")
require("keymaps")
