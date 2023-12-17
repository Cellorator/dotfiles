local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true

-- Editor
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true

opt.breakindent = true
opt.showbreak = "/-/"

-- opt.list = true
-- opt.listchars = { tab = "󰌒 " }

opt.scrolloff = 8

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Random Stuff
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.updatetime = 50

opt.termguicolors = true
