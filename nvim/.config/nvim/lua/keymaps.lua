local map = vim.keymap.set

-- Basic Stuff
map("i", "jj", "<Esc>")
map("n", "<leader>h", "<cmd>bprevious<CR>")
map("n", "<leader>l", "<cmd>bnext<CR>")
map("n", "<leader>r", "<cmd>b#<CR>")
map("n", "<leader>x", "<cmd>bdelete<CR>")

-- Commenting
map("n", "<leader>x", "<cmd>bdelete<CR>")

-- Fzf-Lua
map("n", "<leader>ff", "<cmd>FzfLua files<CR>")
map("n", "<leader>fr", "<cmd>FzfLua buffers<CR>")

-- Autocompletions
local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    }),
})
