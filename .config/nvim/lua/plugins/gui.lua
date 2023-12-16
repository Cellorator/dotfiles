return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
    },
    {
        "akinsho/bufferline.nvim",
        config = function ()
            local bufferline = require("bufferline")
            local options = {
                diagnostics = "nvim-lsp",
                style_preset = {
                    bufferline.style_preset.no_italic,
                },
            }

            require("bufferline").setup({
                options = options,
            })
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function ()
            local options = {
                indent = { char = "│" },
                scope = { enabled = false },
            }
            require("ibl").setup(options)
        end,
    },
}
