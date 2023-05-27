-- A bunch of quality-of-life plugins
return {
    {
        "lukas-reineke/indent-blankline.nvim",
        ft = "*",
    },
    {
        "echasnovski/mini.nvim",
        config = function ()
            require("mini.tabline").setup()

            require("mini.pairs").setup()
        end,
    }
}
