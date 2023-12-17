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
        { "hrsh7th/nvim-cmp", },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
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

        -- Specific lsp setups
        require("lspconfig").lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } }
                }
            }
        })
        require("lspconfig").gdscript.setup({
            on_attach = function()
                vim.api.nvim_command('echo serverstart("/tmp/godot.pipe")')
            end
        })

        lsp.setup()

        -- CMP Setup
        local cmp = require("cmp")
        cmp.setup({
            sources = {
                { name = "nvim_lsp"},
                { name = "nvim_lua"},
                { name = "buffer"},
                { name = "path"},
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),
            }),
        })
    end
}
