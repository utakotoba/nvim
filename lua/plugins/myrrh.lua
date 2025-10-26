--- @type vim.pack.Spec
return {
  src = 'https://github.com/utakotoba/myrrh.nvim.git',
  --- @type lz.n.Spec
  data = {
    lazy = true,
    event = 'BufEnter',
  },
}
