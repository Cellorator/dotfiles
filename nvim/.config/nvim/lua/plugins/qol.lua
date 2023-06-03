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
       "numToStr/Comment.nvim",
       config = function ()
           require("Comment").setup({
               padding = false,

               toggler = {
                   line = "<leader>/"
               },

               opleader = {
                   line = "<leader>/"
               },
           })
       end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = true,
    },
}
