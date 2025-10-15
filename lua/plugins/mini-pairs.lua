--- @type vim.pack.Spec
return {
  src = 'https://github.com/nvim-mini/mini.pairs.git',
  --- @type lz.n.Spec
  data = {
    lazy = true,
    event = 'InsertEnter',
    after = function()
      require('mini.pairs').setup()
    end
  }
}

