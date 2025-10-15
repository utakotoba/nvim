-- neovim global settings
local g = vim.g

-- input & keys
g.mapleader = ' '
g.maplocalleader = ','

-- ui & behavior
g.have_nerd_font = true
g.cursorhold_updatetime = 350

-- disable built-in providers,
-- since only lua configurations are used
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0

-- lsp icons
_G.lsp_icons = {
  Text = ' 󰉿 ',
  Method = ' 󰆧 ',
  Function = ' 󰡱 ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = ' 󰠱 ',
  Interface = '  ',
  Module = '  ',
  Property = ' 󰜢 ',
  Unit = ' 󰑭 ',
  Value = ' 󰎠 ',
  Enum = '  ',
  Keyword = ' 󰌋 ',
  Snippet = '  ',
  Color = ' 󰏘 ',
  File = ' 󰈙 ',
  Reference = ' 󰍎 ',
  Folder = ' 󰉋 ',
  EnumMember = '  ',
  Constant = ' 󰏿 ',
  Struct = ' 󰙅 ',
  Event = '  ',
  Operator = ' 󰆕 ',
  TypeParameter = ' 󰅲 ',
}
