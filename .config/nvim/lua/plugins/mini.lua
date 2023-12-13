return {
    {
        "echasnovski/mini.nim",
        config = function ()
            require("mini.starter").setup()
            require("mini.sessions").setup()
            require("mini.jump").setup()
            require("mini.pairs").setup()
            require("mini.surround").setup()
            require("mini.trailspace").setup()
            require("mini.comment").setup({
                mappings = {
                    comment = '<leader>/',
                    comment_line = '<leader>/',
                    comment_isual = '<leader>/',
                    textobject = '',
                },
            })
        end,
    },
}
