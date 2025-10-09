return {
  src = 'https://github.com/nvim-treesitter/nvim-treesitter.git',
  version = 'main',
  data = {
    -- load tree-sitter early when opening a file from initial command
    lazy = vim.fn.argc(-1) == 0,
    event = { 'BufRead', 'BufNewFile' },
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    after = function()
      require('nvim-treesitter').setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      }
    end
  }
}

