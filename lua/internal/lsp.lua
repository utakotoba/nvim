local M = {}

function M.enable()
  local server_list = {}

  local config_path = vim.fn.stdpath 'config' .. '/lsp'
  local config_files = vim.fn.globpath(config_path, '*.lua', false, true)

  for _, filepath in ipairs(config_files) do
    -- trim file path to get server name to enable,
    -- the actual configs loading is done by neovim
    local server_name = vim.fn.fnamemodify(filepath, ':t:r')
    table.insert(server_list, server_name)
  end

  -- guard, vim.lsp.enable does not accept empty table
  if #server_list ~= 0 then
    vim.lsp.enable(server_list)
  end
end

function M.apply_diagnostic_config()
  vim.diagnostic.config {
    virtual_text = {
      source = 'if_many',
      prefix = ' ',
      spacing = 0,
    },
  }
end

return M
