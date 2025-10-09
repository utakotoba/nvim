-- setup core configuration
require('core.globals')
require('core.options')

-- setup plugin manager

--- Gather plugin specs from config directory
--- @return vim.pack.Spec[] Combined plugin specs
local function gather_plugin_spces()
  local specs = {}

  local target_path = vim.fn.stdpath('config') .. '/lua/plugins'

  if not vim.uv.fs_stat(target_path) then
    return specs
  end

  local spec_files = vim.fn.globpath(target_path, '*.lua', false, true)

  for _, filepath in ipairs(spec_files) do
    -- trim file path to get file name without ext
    local filename = vim.fn.fnamemodify(filepath, ':t:r')

    local module_name = 'plugins.' .. filename
    
    -- assume that all specs in `vim.pack.Spec` type
    local ok, spec = pcall(require, module_name)

    if ok then
      table.insert(specs, spec)
    else
      vim.notify(
        string.format('Failed to load plugin spec: `%s`', module_name),
        vim.log.levels.ERROR
      )
    end
  end

  return specs
end

require('core.pack').load(gather_plugin_spces())

