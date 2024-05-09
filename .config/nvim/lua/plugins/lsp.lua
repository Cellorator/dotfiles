return {
    "neovim/nvim-lspconfig",
    dependencies = {
		{ "williamboman/mason.nvim", },
        { "williamboman/mason-lspconfig.nvim" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
		{ "L3MON4D3/LuaSnip" },
		{ "saadparwaiz1/cmp_luasnip" },
    },
    config = function()
        local lsp = require("lspconfig")
		local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

		-- Mason LSP Setups
		local default_setup = function(server)
			lsp[server].setup({
				capabilities = lsp_capabilities,
			})
		end

		local lua_setup = function()
			lsp.lua_ls.setup({
				settings = {
					Lua = { diagnostics = { globals = { "vim" } } }
				}
			})
		end

		require('mason').setup({})
		require('mason-lspconfig').setup({
			ensure_installed = { "lua_ls" },
			handlers = {
				default_setup,
				lua_ls = lua_setup
			},
		})

        -- Manual LSP setups
        lsp.gdscript.setup({
			on_attach = function()
				vim.api.nvim_command('echo serverstart("/tmp/godot.pipe")')  -- For opening files from godot into neovim
			end
        })

        local cmp = require("cmp")
        cmp.setup({
            sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
				{ name = "luasnip" },
                { name = "path" },
                { name = "buffer" },
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),
				['<C-Space>'] = cmp.mapping.complete(),
            }),
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end
			}
        })

		-- LuaSnip Setup
		local luasnip = require("luasnip")
		vim.keymap.set({"i", "s"}, "<C-L>", function() luasnip.jump(1) end, {silent = true})
		vim.keymap.set({"i", "s"}, "<C-H>", function() luasnip.jump(-1) end, {silent = true})
    end
}
