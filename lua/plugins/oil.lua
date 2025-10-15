--- @type vim.pack.Spec
return {
  src = 'https://github.com/stevearc/oil.nvim.git',
  --- @type lz.n.Spec
  data = {
    lazy = false,
    after = function()
      --- @type oil.Config
      --- @diagnostic disable-next-line: missing-fields
      local opts = {
        columns = {
          'permissions',
          'size',
        },
        delete_to_trash = true,
        keymaps = {
          ['<C-o>'] = { 'actions.select', opts = { vertical = true } },
          ['<C-p'] = { 'actions.select', opts = { horizontal = true } },
        }
      }

      require('oil').setup(opts)
    end
  }
}

