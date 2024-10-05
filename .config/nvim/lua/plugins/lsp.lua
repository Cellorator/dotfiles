return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true;
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
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

			require("mason-lspconfig").setup({
				handlers = {
					default_setup,
				},
			})

			-- Manual LSP setups
			lsp.gdscript.setup({
				on_attach = function()
					vim.api.nvim_command('echo serverstart("/tmp/godot.pipe")')  -- For opening files from godot into neovim
				end
			})
		end
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "luasnip" },
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end
				}
			})
		end
	}
}
