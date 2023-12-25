return {
    {
        "ellisonleao/gruvbox.nvim",
        -- priority = 1000,
        -- config = function ()
        --     vim.cmd.colorscheme("gruvbox")
        -- end
    },
    {
        "sainnhe/gruvbox-material",
        priority = 1000,
        config = function ()
			vim.g.gruvbox_material_foreground = "mix"
            vim.cmd.colorscheme("gruvbox-material")
        end
    },
}
