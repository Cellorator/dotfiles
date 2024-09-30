return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function ()
            local map = vim.keymap.set
            map("n", "<leader>ff", "<cmd>FzfLua files<CR>")
            map("n", "<leader>fr", "<cmd>FzfLua buffers<CR>")
            map("n", "<leader>dd", "<cmd>FzfLua dap_commands<CR>")
        end
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        config = function ()
            vim.o.foldcolumn = "0" -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Using ufo provider need remap `zR` and `zM`.
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
            require("ufo").setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return {"treesitter", "indent" }
                end
            })
        end
    },
    {
        "chrisgrieser/nvim-origami",
        event = "VeryLazy",
        opts = {},
    },
    {
        "epwalsh/obsidian.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            workspaces = {
                {
                    name = "school",
                    path = "~/Obsidian/School/",
                }
            },
            daily_notes = {
                folder = "Daily Notes",
                template = "Daily Notes/Template.md"
            },
            ui = { enable = false },
        }
    },
    {
        "jbyuki/nabla.nvim",
        config = function ()
            vim.keymap.set("n", "<leader>p", ":lua require('nabla').popup()<CR>")
        end
    }
}
