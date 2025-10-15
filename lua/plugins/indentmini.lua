--- @type vim.pack.Spec
return {
  src = 'https://github.com/nvimdev/indentmini.nvim.git',
  --- @type lz.n.Spec
  data = {
    lazy = true,
    event = 'BufEnter',
    after = function()
      --- @diagnostic disable-next-line: undefined-field
      require('indentmini').setup()
    end,
  },
}
