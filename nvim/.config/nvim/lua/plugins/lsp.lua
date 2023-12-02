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
        {
            "hrsh7th/nvim-cmp",
            config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                }),
            })
            end
        },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "L3MON4D3/LuaSnip" },
        { "saadparwaiz1/cmp_luasnip" },
    },
    config = function()
        -- LSP Setup
        local lsp = require("lsp-zero").preset("recommended")

        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({buffer = bufnr})
        end)

        lsp.ensure_installed({
            "lua_ls",
            "rust_analyzer",
        })

        require("lspconfig").lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } }
                }
            }
        })
        lsp.setup()
    end
}
