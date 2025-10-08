local M = {}

function M.init()
  -- use neovim's built-in plugin manager to download lz.n
  vim.pack.add({
    'https://github.com/lumen-oss/lz.n.git'
  }, {
    confirm = false -- automatically
  })
end

function M:load()
  -- indicator for plugin loading state
  self.is_ok = false

  -- target path to confirm that lz.n initialized (vim.pack managed path)
  -- use to indicate that local copies of plugins exist
  local lzn_path = vim.fn.stdpath('data') .. '/site/pack/core/opt/lz.n'
  
  if vim.uv.fs_stat(lzn_path) then
    -- if lz.n exists, init directly before showing ui
    M.init()
    self.is_ok = true

    -- load all specs under `plugins`
    local specs = require('plugins').gather_plugin_specs()
    if #specs ~= 0 then
      vim.pack.add(specs, {
        load = require('lz.n').load, -- custom loader for lazy-loading
        confirm = false, -- automatically
      })
    end
  end
end

return M

