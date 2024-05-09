return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = { "lua", "vim", "vimdoc" },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end
}
