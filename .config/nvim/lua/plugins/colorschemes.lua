return {
    {
        "ellisonleao/gruvbox.nvim",
		config = function ()
			require("gruvbox").setup({
				overrides = {
					["@punctuation.bracket"] = { fg = "#ebdbb2" },
					["@punctuation.delimiter"] = { fg = "#928374" },
					["@constructor"] = { fg = "#ebdbb2" },
				}
			})
			-- vim.cmd.colorscheme("gruvbox")
		end
    },
    {
        "sainnhe/gruvbox-material",
        config = function ()
            -- vim.cmd.colorscheme("gruvbox-material")
        end
    },
	{
        "rebelot/kanagawa.nvim",
        config = function ()
            -- vim.cmd.colorscheme("kanagawa-dragon")
        end
    },
    {
          "sho-87/kanagawa-paper.nvim",
          lazy = false,
          priority = 1000,
          opts = {},
    },
}
