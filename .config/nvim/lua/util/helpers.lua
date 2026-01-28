-- lua/util/helpers.lua
local M = {}

M.format_on_save = true

function M.toggle_format_on_save()
  M.format_on_save = not M.format_on_save
  vim.notify("Format on save: " .. tostring(M.format_on_save))
end

return M
