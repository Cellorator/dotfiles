local map = vim.keymap.set

map("i", "jj", "<Esc>")

-- Telescope
local builtin = require("telescope/builtin")
map("n", "<leader>ff", builtin.find_files)

-- Autocompletions
local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    }),
})
