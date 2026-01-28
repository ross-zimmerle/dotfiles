-- lua/plugins/init.lua
return {
  -- Useful plugin to show you pending keybinds.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require("which-key")
      wk.setup()
      
      -- Register group names
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>t", group = "Toggle/Tools" },
        { "<leader>x", group = "Trouble" },
        { "<leader>s", group = "Search" },
        { "<leader>c", group = "Code" },
      })
    end,
  },
}
