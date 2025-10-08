return {
  src = 'https://github.com/neanias/everforest-nvim.git',
  data = {
    lazy = false,
    priority = 1000,
    after = function()
      -- modify theme settings
      require('everforest').setup({
        background = 'hard',
        transparent_background_level = 2,
        italics = true,
        ui_contrast = 'low',
        show_eob = false,
      })

      -- apply colorscheme immediately to prevent flashing
      vim.cmd.colorscheme('everforest')
    end,
  }
}

