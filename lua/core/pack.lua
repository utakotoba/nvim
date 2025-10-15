local M = {}

--- Get te plugin name from a given spec
--- @param spec vim.pack.Spec Target vim.pack spec
--- @return string?
local function get_plugin_name(spec)
  if spec.name then
    return spec.name
  end

  local src = type(spec) == 'string' and spec or spec.src
  return src:match '([^/]+)%.git$' or src:match '([^/]+)$'
end

--- Get the vim.pack managed package path
--- @return string Path string to pack dir
local function get_pack_dir()
  local data_path = vim.fn.stdpath 'data'
  --- @diagnostic disable-next-line: param-type-not-match
  return vim.fs.joinpath(data_path, 'site', 'pack', 'core', 'opt')
end

--- Scan vim.pack installation directory to get installed plugins list
--- @return table<string, boolean> Table of installed plugins found on local disk
local function scan_installed_plugins()
  local pack_dir = get_pack_dir()

  --- @type table<string, boolean>
  local installed_plugins = {}

  local stat = vim.uv.fs_stat(pack_dir)
  if not stat or stat.type ~= 'directory' then
    return installed_plugins
  end

  local handle = vim.uv.fs_scandir(pack_dir)
  if not handle then
    return installed_plugins
  end

  while true do
    local name, type = vim.uv.fs_scandir_next(handle)
    if not name then
      break
    end

    if type == 'directory' and name ~= 'lz.n' then
      installed_plugins[name] = true
    end
  end

  return installed_plugins
end

--- Check given specs' plugins installation status
--- @param specs vim.pack.Spec[] List of vim.pack plugin specs
--- @return vim.pack.Spec[] Installed plugins' specs
--- @return vim.pack.Spec[] Local missing plugins' specs
function M.check(specs)
  local installed_plugins = scan_installed_plugins()

  --- @type vim.pack.Spec[]
  local installed_specs = {}

  --- @type vim.pack.Spec[]
  local missing_specs = {}

  for _, spec in ipairs(specs) do
    local plugin_name = get_plugin_name(spec)
    if installed_plugins[plugin_name] then
      table.insert(installed_specs, spec)
    else
      table.insert(missing_specs, spec)
    end
  end

  return installed_specs, missing_specs
end

--- Load plugins from given vim.pack specs
--- @param specs vim.pack.Spec[] List of specs need to be install
function M.load_plugins(specs)
  if #specs > 0 then
    vim.pack.add(specs, {
      load = require('lz.n').load,
    })
  end
end

--- Deferred install missing plugins
--- @param specs vim.pack.Spec[] List of missing plugins
function M.defer_load_plugins(specs)
  vim.api.nvim_create_autocmd('UIEnter', {
    once = true,
    callback = function()
      vim.defer_fn(function()
        vim.notify(
          'Missing plugins detected, installing...',
          vim.log.levels.WARN
        )
        vim.wait(1000)

        vim.schedule(function()
          local install_time = vim.uv.hrtime()

          vim.pack.add(specs, {
            -- only download without load, as we'll restart
            load = false,
            -- automatically install missing plugins
            confirm = false,
          })

          install_time = (vim.uv.hrtime() - install_time) / 1e6

          -- defer for 200 ms to make sure the notify called after vim.pack message
          vim.defer_fn(function()
            vim.notify(
              string.format('Finished in %d ms, restart!', install_time),
              vim.log.levels.INFO
            )

            vim.wait(750)

            -- call neovim built-in restart to make sure event triggering
            vim.cmd.restart()
          end, 200)
        end)
      end, 150)
    end,
  })
end

--- Ensure lz.n installed
function M.ensure_lzn()
  -- set background to transparent first to avoid buggy visual feeling
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'WinBar', { bg = 'NONE' })

  vim.pack.add({
    'https://github.com/lumen-oss/lz.n.git',
  }, {
    -- automatically install before ui loading (very early)
    confirm = false,
  })
end

--- Register pack's related user command
function M.register_commands()
  -- update command
  vim.api.nvim_create_user_command('UpdatePlugins', function()
    vim.pack.update()
  end, {
    desc = 'Update all plugins via vim.pack',
  })
end

--- Load plugins using given specs with auto missing installation
--- @param specs vim.pack.Spec[] List of vim.pack plugin specs
function M.load(specs)
  M.ensure_lzn()

  local installed_specs, missing_specs = M.check(specs)

  -- load local installed plugins first
  if #installed_specs > 0 then
    M.load_plugins(installed_specs)
  end

  -- defer to download missing plugins after entering ui
  if #missing_specs > 0 then
    M.defer_load_plugins(missing_specs)
  end

  M.register_commands()
end

return M
