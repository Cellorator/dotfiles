return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function ()
			require("gruvbox").setup({
				overrides = {
					["@punctuation.bracket"] = { fg = "#ebdbb2" },
					["@punctuation.delimiter"] = { fg = "#928374" },
					["@constructor"] = { fg = "#ebdbb2" },
				}
			})
            vim.cmd.colorscheme("gruvbox")
        end
    },
    {
        "sainnhe/gruvbox-material",
        -- priority = 1000,
        -- config = function ()
        --     vim.cmd.colorscheme("gruvbox-material")
        -- end
    }
}
