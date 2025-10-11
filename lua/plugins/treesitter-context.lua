--- @type vim.pack.Spec
return {
  src = 'https://github.com/nvim-treesitter/nvim-treesitter-context.git',
  --- @type lz.n.Spec
  data = {
    -- follow tree-sitter plugin behavior
    lazy = vim.fn.argc(-1) == 0,
    event = { 'BufEnter' },
    after = function()
      require 'treesitter-context'.setup {
        mode = 'topline',
      }
    end
  }
}

