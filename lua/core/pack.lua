local M = {}

function M.init()
  -- use neovim's built-in plugin manager to download lz.n
  vim.pack.add({
    'https://github.com/lumen-oss/lz.n.git'
  }, {
    confirm = false -- automatically
  })
end

local function gather_plugin_specs()
  local result = {}

  local specs_path = vim.fn.stdpath('config') .. '/lua/plugins'

  if not vim.uv.fs_stat(specs_path) then
    -- return empty table if no spec
    return result
  end

  local spec_files = vim.fn.globpath(specs_path, '*.lua', false, true)
  
  for _, filepath in ipairs(spec_files) do
    -- trim file path to get file name without ext
    local filename = vim.fn.fnamemodify(filepath, ':t:r')

    local module_name = 'plugins.' .. filename

    -- assume that all specs in `vim.pack.Spec` type
    local ok, spec = pcall(require, module_name)

    if ok then
      table.insert(result, spec)
    else
      vim.notify(
        string.format('Failed to load plugin spec: `%s`', module_name),
        vim.log.levels.ERROR
      )
    end
  end

  return result
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
    local specs = gather_plugin_specs()
    if #specs ~= 0 then
      vim.pack.add(specs, {
        load = require('lz.n').load, -- custom loader for lazy-loading
        confirm = false, -- automatically
      })
    end
  end
end

return M

