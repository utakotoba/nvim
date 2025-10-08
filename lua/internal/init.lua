local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('MixtapeGroup', {})

autocmd('BufEnter', {
  group = group,
  once = true,
  callback = function()
    -- schedule to check if lz.n loaded,
    -- if not, clone and load it
    -- this is mostly used for showing the vim.pack installing
    -- progress when first load (need optimize)
    vim.schedule(function()
      local pack = require('core.pack')
      if not pack.is_ok then
        pack.init()
        pack:load()
      end
    end)
  end
})

