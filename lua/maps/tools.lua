local map = vim.keymap.set

local M = {}

--- Keymap for fzf-lua plugins
function M.fzf()
  -- use fzf to open or switch
  map('n', '<leader>f', '<Cmd>FzfLua files<CR>', {
    desc = 'Use Fzf To Open A File',
  })
  map('n', '<leader>b', '<Cmd>FzfLua buffers<CR>', {
    desc = 'Use Fzf To List Opened Buffers',
  })
  map('n', '<leader>m', '<Cmd>FzfLua oldfiles<CR>', {
    desc = 'Use Fzf To List Opened Files History',
  })
  map('n', '<leader>t', '<Cmd>FzfLua tabs<CR>', {
    desc = 'Use Fzf To List Opened Tabs',
  })

  -- grep something in normal mode
  map('n', '<leader>g', '<Cmd>FzfLua lgrep_curbuf<CR>', {
    desc = 'Use Fzf To Grep Current File',
  })
  map('n', '<leader>F', '<Cmd>FzfLua live_grep_native<CR>', {
    desc = 'Use Fzf To Grep Opened Working Directory',
  })

  -- grep something in visual mode
  map('x', '<leader>g', '<Cmd>FzfLua grep_visual<CR>', {
    desc = 'Use Fzf To Grep Current Visual Selection',
  })

  -- resume
  map({ 'n', 'x' }, '<leader>R', '<Cmd>FzfLua resume<CR>', {
    desc = 'Resume Last Fzf Command Or Query',
  })

  -- pages
  map('n', '<leader>ht', '<Cmd>FzfLua helptags<CR>', {
    desc = 'Show Help Tags',
  })
  map('n', '<leader>mp', '<Cmd>FzfLua manpages<CR>', {
    desc = 'Show Man Pages',
  })
  map('n', '<leader>T', '<Cmd>FzfLua filetypes<CR>', {
    desc = 'Show Filetypes',
  })
  map('n', '<leader>rgs', '<Cmd>FzfLua registers<CR>', {
    desc = 'Show Reigisters List',
  })
  map('n', '<leader>cs', '<Cmd>FzfLua colorschemes<CR>', {
    desc = 'Show Colorschemes Selector',
  })
  map('n', '<leader>qf', '<Cmd>FzfLua quickfix<CR>', {
    desc = 'Show Quickfix List',
  })
  map('n', '<leader>ll', '<Cmd>FzfLua loclist<CR>', {
    desc = 'Show Loc List',
  })
end

return M
