return {
  src = 'https://github.com/utakotoba/lspsaga.nvim.git',
  data = {
    lazy = true,
    event = 'LspAttach',
    after = function()
      vim.schedule(function()  
        require('lspsaga').setup({
          ui = {
            devicon = false,
            border = 'rounded',
          },
          symbol_in_winbar = {
            show_file = false,
          },
        })
      end)
    end
  }
}

