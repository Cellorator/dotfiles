local opt = vim.opt

-- Visuals
opt.number = true  -- Show line numbers
opt.relativenumber = true  -- Show relative line numbers
opt.signcolumn = "number"  -- Put gutter symbols in line number column

-- Behaviour
opt.expandtab = true
opt.tabstop = 4  -- Length of a tab
opt.shiftwidth = 4  -- Size of indentation with > and < commands
opt.softtabstop = 4  -- Amount of spaces for tab
opt.smarttab = true
opt.scrolloff = 8  -- Amount of lines before top and bottom while scrolling

-- Search
opt.ignorecase = true  -- Ignore case when searching
opt.smartcase = true  -- Don't ignore case when search has upper case letters
opt.hlsearch = false  -- Stop highlighting when search is done

-- Random Stuff
opt.undofile = true
opt.termguicolors = true

vim.cmd.colorscheme("kanagawa-dragon")
