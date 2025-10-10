return {
  src = 'https://github.com/utakotoba/lspsaga.nvim.git',
  data = {
    lazy = true,
    -- use `BufEnter` instead of `LspAttach` to make sure
    -- the time lspsaga load with buffer gui
    event = 'BufEnter',
    after = function()
      vim.schedule(function()  
        require('lspsaga').setup({
          ui = {
            devicon = false,
            border = 'rounded',
          },
          symbol_in_winbar = {
            show_file = false,
            color_mode = false,
          },
        })
      end)
    end
  }
}

