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
            require("mini.comment").setup({
                mappings = {
                    comment = '<leader>/',
                    comment_line = '<leader>/',
                    comment_visual = '<leader>/',
                    textobject = '',
                },
            })
        end,
    },
}
