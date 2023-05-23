-- A bunch of quality-of-life plugins
return {
    {
        "lukas-reineke/indent-blankline.nvim",
        ft = "*",
    },
    {
        "windwp/nvim-autopairs",
        config = function ()
            require("nvim-autopairs").setup {}
        end
    },
}
