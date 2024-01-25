-- copilot configuration

return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      -- These are disabled in the default configuration.
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
