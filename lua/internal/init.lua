local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('MixtapeGroup', {})

autocmd('BufEnter', {
  group = group,
  once = true,
  callback = function()
    vim.schedule(function()
      -- disable built-in regex syntax
      vim.cmd [[syntax off]]

      -- load lsp
      local lsp = require('internal.lsp')
      lsp.enable()
      lsp.apply_diagnostic_config()
    end)
  end
})

