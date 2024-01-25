-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.wo.wrap = true
vim.diagnostic.config({
  float = { border = "rounded" },
})
