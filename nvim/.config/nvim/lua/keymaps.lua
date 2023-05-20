local map = vim.keymap.set

map("i", "jj", "<Esc>")

-- Telescope
local builtin = require("telescope/builtin")
map("n", "<leader>ff", builtin.find_files)
