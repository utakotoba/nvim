return {
  src = 'https://github.com/Saghen/blink.cmp.git',
  version = 'v1.7.0',
  data = {
    lazy = true,
    event = 'LspAttach',
    after = function()
      require('blink.cmp').setup({
        keymap = {
          preset = 'super-tab',
        },
      })
    end
  }
}

