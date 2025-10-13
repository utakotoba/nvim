--- @type vim.pack.Spec
return {
  src = 'https://github.com/ibhagwan/fzf-lua.git',
  --- @type lz.n.Spec
  data = {
    lazy = true,
    cmd = 'FzfLua',
    after = function()
      require 'fzf-lua'.setup {
        winopts = {
          backdrop = 36,
          preview = {
            title_pos = 'right',
          },
        },
        actions = {
          files = {
            ['enter'] = FzfLua.actions.file_switch_or_edit,
            ['ctrl-o'] = FzfLua.actions.file_vsplit,
            ['ctrl-p'] = FzfLua.actions.file_split,
            ['ctrl-a'] = FzfLua.actions.file_tabedit,
          },
        },
        lsp = {
          symbols = {
            symbol_icons = _G.lsp_icons,
          },
        },
      }
    end
  },
}

