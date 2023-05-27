-- A bunch of quality-of-life plugins
return {
    {
        "echasnovski/mini.nvim",
        config = function ()
            require("mini.starter").setup()
            require("mini.sessions").setup()
            require("mini.tabline").setup()

            require("mini.jump").setup()
            require("mini.pairs").setup()
            require("mini.trailspace").setup()
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            require("indent_blankline").setup()
        end,
        ft = "*",
    },
}
