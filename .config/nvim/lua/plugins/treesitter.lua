return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = { "lua", "vim", "vimdoc", "rust", "python"},
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end
}
