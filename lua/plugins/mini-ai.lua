--- @type vim.pack.Spec
return {
  src = 'https://github.com/nvim-mini/mini.ai.git',
  --- @type lz.n.Spec
  data = {
    lazy = true,
    event = 'InsertEnter',
    after = function()
      require('mini.ai').setup()
    end,
  },
}
