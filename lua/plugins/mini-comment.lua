--- @type vim.pack.Spec
return {
  src = 'https://github.com/nvim-mini/mini.comment.git',
  --- @type lz.n.Spec
  data = {
    lazy = true,
    event = 'InsertEnter',
    after = function()
      require('mini.comment').setup()
    end
  }
}

