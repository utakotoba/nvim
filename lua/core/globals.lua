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

-- neovide-specified
if g.neovide then
  -- window related configurations
  g.neovide_opacity = 1
  g.neovide_normal_opacity = 0.88
  g.transparency = 0.88
  g.neovide_window_blurred = true
  g.neovide_show_border = true

  -- window padding
  g.neovide_padding_top = 28
  g.neovide_padding_bottom = 12
  g.neovide_padding_left = 16
  g.neovide_padding_right = 16

  -- animation settings
  g.neovide_position_animation_length = 0.25
  g.neovide_scroll_animation_far_lines = 999
end
