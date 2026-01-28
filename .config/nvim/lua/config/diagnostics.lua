-- lua/config/diagnostics.lua

local M = {}

function M.setup()
  local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    virtual_text = {
      prefix = "●",
      source = "if_many", -- Or "always"
    },
    float = {
      source = "always",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })
end

return M
