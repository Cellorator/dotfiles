return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				section_separators = { left = "", right = ""},
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					"mode",
                    "searchcount",
				},
				lualine_b = {
					"filename",
					"diagnostics",
					"branch",
					"diff",
				},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {
                    "fileformat",
					"encoding",
					"filetype",
				},
				lualine_z = {
					"progress",
					"location"
				}
			}
		}
    },
	{
		"utilyre/barbecue.nvim",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		config = true
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
    {
        "NvChad/nvim-colorizer.lua",
        config = function ()
            require("colorizer").setup({
                user_default_options = {
                    names = false,
                }
            })
        end,
    }
}
