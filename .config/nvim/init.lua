-- Enable source code highlighting
vim.cmd('syntax on')

-- Set hybrid line numbers on
vim.wo.number = true
vim.wo.relativenumber = true

-- Set tab width to 4 columns
vim.bo.tabstop = 4
-- Use space characters instead of tabs
vim.bo.expandtab = true
vim.cmd('filetype indent on')

-- Do not save backup files
vim.o.backup = false

-- Ignore caps during search except if caps are used
vim.o.ignorecase = true
vim.o.smartcase = true

-- Incrementally highlight matching characters in search and use highlighting, repaint screen cancelling search highlights
vim.o.incsearch = true
vim.o.hlsearch = true
vim.api.nvim_set_keymap('n', '<C-L>', ':nohls<CR><C-L>', { noremap = true, silent = true })

-- Add lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require("lazy").setup({
{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd[[colorscheme tokyonight-night]]
  end,
},
{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
}
})

require('lualine').setup()
