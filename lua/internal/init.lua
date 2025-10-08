local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('MixtapeGroup', {})

autocmd('BufEnter', {
  group = group,
  once = true,
  callback = function()
    vim.schedule(function()
      -- schedule to check if lz.n loaded,
      -- if not, clone and load it
      -- this is mostly used for showing the vim.pack installing
      -- progress when first load (need optimize)
      local pack = require('core.pack')

      ---@diagnostic disable-next-line: unnecessary-if
      if not pack.is_ok then
        pack.init()
        pack:load()
      end

      -- load lsp
      local lsp = require('internal.lsp')
      lsp.enable()
      lsp.apply_diagnostic_config()
    end)
  end
})

