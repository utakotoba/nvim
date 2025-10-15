local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('MixtapeGroup', {})

autocmd('BufWinEnter', {
  group = group,
  once = true,
  callback = function()
    -- load statusline
    local stl = require 'internal.stl'
    stl.load()
  end,
})

autocmd('BufEnter', {
  group = group,
  once = true,
  callback = function()
    vim.schedule(function()
      -- load lsp
      local lsp = require 'internal.lsp'
      lsp.enable()
      lsp.apply_diagnostic_config()

      -- load keymap
      local base_keymap = require 'maps.base'
      base_keymap.control()
      base_keymap.window_control()
      base_keymap.base_movement()

      local tools_keymap = require 'maps.tools'
      tools_keymap.fzf()

      local development_keymap = require 'maps.development'
      development_keymap.lsp()
    end)
  end,
})
