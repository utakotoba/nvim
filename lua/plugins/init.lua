local M = {}

function M.gather_plugin_specs()
  local result = {}

  local specs_path = vim.fn.stdpath('config') .. '/lua/plugins'

  if not vim.uv.fs_stat(specs_path) then
    return result
  end

  local spec_files = vim.fn.globpath(specs_path, '*.lua', false, true)
  
  for _, filepath in ipairs(spec_files) do
    local filename = vim.fn.fnamemodify(filepath, ':t:r')

    if filename ~= 'init' then
      local module_name = 'plugins.' .. filename

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
  end

  return result
end

return M

