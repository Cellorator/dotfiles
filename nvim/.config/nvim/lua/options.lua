local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Editor
opt.breakindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Theme
opt.termguicolors = true
vim.cmd.colorscheme("gruvbox-material")
