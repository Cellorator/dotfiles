return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
    },
    {
        "akinsho/bufferline.nvim",
        config = function ()
            local options = {
               diagnostics = "nvim-lsp",
            }
            local highlights = {
                buffer_selected = { italic = false },
            }

            require("bufferline").setup({
                options = options,
                highlights = highlights,
            })
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = true,
    },
}
