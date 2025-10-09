return {
  src = 'https://github.com/nvim-treesitter/nvim-treesitter.git',
  data = {
    lazy = true,
    event = { 'BufRead', 'BufNewFile' },
    after = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'c',
          'cpp',
          'lua',
          'json',
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end
  }
}

