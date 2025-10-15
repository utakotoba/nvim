--- @type vim.pack.Spec
return {
  src = 'https://github.com/nvim-mini/mini.splitjoin.git',
  --- @type lz.n.Spec
  data = {
    lazy = true,
    event = 'BufEnter',
    after = function()
      -- schedule to load, since this is not such necessary
      vim.schedule(function()
        require('mini.splitjoin').setup()
      end)
    end,
  },
}
