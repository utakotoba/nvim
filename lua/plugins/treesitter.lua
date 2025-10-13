--- List of language parsers should be always installed
--- @type string[] list of parser names
local ensure_installed = {
  'c',
  'cpp',
  'lua',
  'json',
  'go',
}

--- Ensure all language parsers in given list installed
--- @param parsers string[] List of parsers will be installed
local function ensure_parsers(parsers)
  local TS = require('nvim-treesitter')

  --- @type string[]
  local current_installed = TS.get_installed()

  -- build lookup table for exclude
  local installed_lookup = {}
  for _, v in ipairs(current_installed) do
    installed_lookup[v] = true
  end

  -- get list of parsers need to install
  local filtered = vim.tbl_filter(function(item)
    return not installed_lookup[item] 
  end, parsers)

  TS.install(filtered)
end

return {
  src = 'https://github.com/nvim-treesitter/nvim-treesitter.git',
  version = 'main',
  data = {
    -- load tree-sitter early when opening a file from initial command
    lazy = vim.fn.argc(-1) == 0,
    event = { 'BufRead', 'BufNewFile' },
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    after = function()
      -- startup checking
      vim.api.nvim_create_autocmd('UIEnter', {
        once = true,
        callback = function()
          vim.schedule(function()
            -- install missing parser
            ensure_parsers(ensure_installed)
          end)
        end
      })

      -- features setup
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          vim.schedule(function()
            local ok = pcall(function()
              local _ = vim.treesitter.get_parser(0, args.match) 
            end)

            if ok then
              -- start highlighting
              vim.treesitter.start()

              -- start folds
              vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

              -- start indentation
              vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

              -- disable built-in regex syntax
              vim.cmd [[syntax off]]
            else
              -- enable built-in regex syntax as fallback
              vim.cmd [[syntax on]]
            end
          end)
        end
      })
    end,
  },
}

