-- A bunch of quality-of-life plugins
return {
    {
        "echasnovski/mini.nvim",
        config = function ()
            require("mini.tabline").setup()

            require("mini.pairs").setup()
        end
    }
}
