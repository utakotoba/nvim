--- @diagnostic disable: assign-type-mismatch
--- @diagnostic disable: missing-fields

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
          },
          ['<C-s>'] = {
            'show_signature',
            'hide_signature',
            'fallback',
          },
        },
        appearance = {
          kind_icons = _G.lsp_icons,
        },
        completion = {
          menu = {
            winblend = 4,
            draw = {
              columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
            treesitter_highlighting = true,
            window = {
              winblend = 4,
            },
          },
          list = { selection = { preselect = true, auto_insert = true } },
          accept = { auto_brackets = { enabled = true } },
          ghost_text = { enabled = true },
        },
        signature = {
          enabled = true,
          trigger = {
            show_on_accept = true,
            show_on_insert = true,
          },
          window = {
            winblend = 4,
          },
        },
        sources = { default = { 'snippets', 'lsp', 'path', 'buffer' } },
      }

      vim.schedule(function()
        --- @diagnostic disable-next-line: undefined-field, redundant-parameter
        require 'blink.cmp'.setup(opts)
      end)
    end
  }
}

