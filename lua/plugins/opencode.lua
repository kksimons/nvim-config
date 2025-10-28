return {
  {
    dir = "/Users/ksimons/repos/nvim-opencode", -- Local path for testing
    name = "nvim-opencode",
    event = "VeryLazy",
    config = function()
      require("opencode").setup({
        keybind = "<leader>a",  -- Toggle with leader+a
        terminal_size = 0.5,    -- 50% of screen width
        position = "right",     -- Right split like file explorer
      })
    end,
    keys = {
      { "<leader>a", function() require("opencode").toggle() end, desc = "Toggle opencode" },
    },
  },
}