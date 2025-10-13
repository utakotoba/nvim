--- @type vim.pack.Spec
return {
  src = 'https://github.com/neanias/everforest-nvim.git',
  --- @type lz.n.Spec
  data = {
    lazy = false,
    priority = 1000,
    after = function()
      --- @type Everforest.Config
      --- @diagnostic disable-next-line: missing-fields
      local opts = {
        background = 'hard',
        transparent_background_level = 2,
        italics = true,
        ui_contrast = 'low',
        show_eob = false,
        on_highlights = function(hl, palette)
          -- override some blink.cmp colors,
          -- only affect its groups in global
          hl.BlinkCmpMenu = { fg = palette.fg, bg = palette.bg1 }
          hl.BlinkCmpLabel = { fg = palette.fg, bg = palette.bg1 }
          hl.BlinkCmpLabelDetail = { fg = palette.grey0 }
          hl.BlinkCmpLabelDescription = { fg = palette.grey0 }
          hl.BlinkCmpDoc = { fg = palette.fg, bg = palette.bg1 }
          hl.BlinkCmpSignatureHelp = { fg = palette.fg, bg = palette.bg1 }
        end
      }

      -- modify theme settings
      require('everforest').setup(opts)

      -- apply colorscheme immediately to prevent flashing
      vim.cmd.colorscheme('everforest')
    end,
  }
}

