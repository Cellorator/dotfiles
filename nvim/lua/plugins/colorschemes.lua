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
		end
    },
    {
        "sainnhe/gruvbox-material",
    },
	{
        "rebelot/kanagawa.nvim",
    },
}
