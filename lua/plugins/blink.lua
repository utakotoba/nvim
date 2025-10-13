--- @diagnostic disable: assign-type-mismatch
--- @diagnostic disable: missing-fields

local icons = {
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

--- @type vim.pack.Spec
return {
  src = 'https://github.com/Saghen/blink.cmp.git',
  version = 'v1.7.0',
  --- @type lz.n.Spec
  data = {
    lazy = true,
    event = 'LspAttach',
    after = function()
      --- @type blink.cmp.Config
      local opts = {
        keymap = {
          -- these keymaps will override the insert mode cursor movements
          ['<C-j>'] = {
            'select_next',
            'snippet_forward',
            'fallback',
          },
          ['<C-k>'] = {
            'select_prev',
            'snippet_backward',
            'fallback',
          },
          ['<Tab>'] = {
            'accept',
            'fallback'
          },
          ['<CR>'] = {
            'accept',
            'fallback',
          }
        },
        appearance = {
          kind_icons = icons,
        },
        completion = {
          menu = {
            draw = {
              columns = { { 'kind_icon' }, { 'label', 'label_description' }, { 'kind' } },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
            treesitter_highlighting = true,
          },
          list = { selection = { preselect = true, auto_insert = true } },
          accept = { auto_brackets = { enabled = true } },
          ghost_text = { enabled = true },
        },
        sources = { default = { 'snippets', 'lsp', 'path', 'buffer' } },
        cmdline = {},
        signature = { window = { border = 'rounded' } },
      }

      vim.schedule(function() 
        require 'blink.cmp'.setup(opts)
      end)
    end
  }
}

