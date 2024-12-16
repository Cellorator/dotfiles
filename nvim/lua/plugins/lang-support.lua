return {
    {
        "sophacles/vim-processing",
        ft = "processing",
        config = function ()
            vim.g.processing_no_default_mappings = true
            vim.keymap.set("n", "<Leader>r", "<Plug>(processing-run)")
        end
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            latex = { enabled = false },
            win_options = {
                conceallevel = { rendered = 2 }
            }
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "robbielyman/latex.nvim",
        config = true,
    }
}
