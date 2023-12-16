return {
    {
        "echasnovski/mini.nvim",
        config = function ()
            require("mini.jump").setup()
            require("mini.pairs").setup()
            require("mini.surround").setup()
            require("mini.trailspace").setup()
            require("mini.comment").setup()
        end,
    },
}
