local map = vim.keymap.set

-- Basic Stuff
map("i", "jj", "<Esc>")
map("n", "<leader>h", "<cmd>bprevious<CR>")
map("n", "<leader>l", "<cmd>bnext<CR>")
map("n", "<leader><tab>", "<cmd>b#<CR>")
map("n", "<leader>w", "<cmd>bdelete<CR>")
