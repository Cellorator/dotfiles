return {
    {
        "ellisonleao/gruvbox.nvim",
        -- priority = 1000,
        -- config = function ()
        --     vim.cmd.colorscheme("gruvbox")
        -- end
    },
    { "sainnhe/sonokai"},
    {
        "sainnhe/gruvbox-material",
        priority = 1000,
        config = function ()
            vim.cmd.colorscheme("gruvbox-material")
        end
},
    { "Shatur/neovim-ayu"},
}
