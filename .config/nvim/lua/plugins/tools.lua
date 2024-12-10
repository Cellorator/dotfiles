return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function ()
            local map = vim.keymap.set
            map("n", "<leader>ff", "<cmd>FzfLua files<CR>")
            map("n", "<leader>fr", "<cmd>FzfLua buffers<CR>")
            map("n", "<leader>dd", "<cmd>FzfLua dap_commands<CR>")
        end
    }
}
