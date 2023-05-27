local map = vim.keymap.set

map("i", "jj", "<Esc>")

-- Fzf-Lua
map("n", "<leader>ff", "<cmd>FzfLua files<CR>")
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>")

-- Autocompletions
local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    }),
})
