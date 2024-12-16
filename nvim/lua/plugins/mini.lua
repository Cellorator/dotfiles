return {
    {
        "echasnovski/mini.nvim",
        config = function ()
            require("mini.pairs").setup()
            require("mini.trailspace").setup()
            require("mini.comment").setup()
        end,
    },
}
