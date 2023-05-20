-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
--local plugins = {
--    -- Colorschemes
--    { "sainnhe/gruvbox-material" },
--    { "catppuccin/nvim", name = "catppuccin" },
--    "Shatur/neovim-ayu",
--
--    -- UI
--    {"nvim-lualine/lualine.nvim"},
--}

local opts = {}

require("lazy").setup("plugins", opts)
