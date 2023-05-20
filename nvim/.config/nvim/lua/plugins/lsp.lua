return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        -- LSP
        { "neovim/nvim-lspconfig" },
        {
            "williamboman/mason.nvim",
            build = function()
                pcall(vim.cmd, "MasonUpdate")
            end,
        },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
    },
    config = function()
        local lsp = require("lsp-zero").preset({})

        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({buffer = bufnr})
        end)

        lsp.ensure_installed({
            "lua_ls",
            "rust_analyzer",
        })

        lsp.setup()
    end
}
