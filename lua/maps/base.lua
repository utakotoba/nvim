local map = vim.keymap.set

local M = {}

--- Mapping for basic cursor movement
function M.base_movement()
  -- wrapped lines aware up and down movement
  local better_up = 'v:count == 0 ? "gk" : "k"'
  local better_down = 'v:count == 0? "gj" : "j"'
  map({ 'n', 'x' }, 'k', better_up, {
    desc = 'Move Cursor Up',
    expr = true, silent = true
  })
  map({ 'n', 'x' }, 'j', better_down, {
    desc = 'Move Cursor Down',
    expr = true, silent = true
  })
  map({ 'n', 'x' }, '<Up>', better_up, {
    desc = 'Move Cursor Up',
    expr = true, silent = true
  })
  map({ 'n', 'x' }, '<Down>', better_down, {
    desc = 'Move Cursor Down',
    expr = true, silent = true
  })

  -- insert mode, cursor movement (less used)
  map('i', '<C-k>', '<Up>', {
    desc = 'Move Cursor Up', noremap = true
  })
  map('i', '<C-j>', '<Down>',
    { desc = 'Move Cursor Down', noremap = true
  })
  map('i', '<C-h>', '<Left>',
    { desc = 'Move Cursor Left', noremap = true
  })
  map('i', '<C-l>', '<Right>',
    { desc = 'Move Cursor Right', noremap = true
  })
end

--- Window / Split related controlling mapping
function M.window_control()
  -- use cursor in normal mode to move around different windows
  map('n', '<C-k>', '<C-w>k', {
    desc = 'Move Cursor To Upper Window', noremap = true
  })
  map('n', '<C-j>', '<C-w>j', {
    desc = 'Move Cursor To Lower Window', noremap = true
  })
  map('n', '<C-h>', '<C-w>h', {
    desc = 'Move Cursor To Left Window', noremap = true
  })
  map('n', '<C-l>', '<C-w>l', {
    desc = 'Move Cursor To Right Window', noremap = true
  })

  -- loop select window
  map('n', '<leader>ww', '<C-w>w', {
    desc = 'Cycle Select Next Window', noremap = true
  })

  -- window splitting
  map('n', '<leader>sk', '<Cmd>set nosplitbelow | split<CR>', {
    desc = 'Split Current Window To Top'
  })
  map('n', '<leader>sj', '<Cmd>set splitbelow | split<CR>', {
    desc = 'Split Current Window To Down'
  })
  map('n', '<leader>sh', '<Cmd>set nosplitright | vsplit<CR>', {
    desc = 'Split Current Window To Left'
  })
  map('n', '<leader>sl', '<Cmd>set splitright | vsplit<CR>', {
    desc = 'Split Current Window To Right'
  })

  -- window sizing
  map('n', '<S-Up>', '<Cmd>resize +4<CR>', {
    desc = 'Increase Height Of Current Window'
  })
  map('n', '<S-Down>', '<Cmd>resize -4<CR>', {
    desc = 'Decrease Height Of Current Window'
  })
  map('n', '<S-Left>', '<Cmd>vertical resize +4<CR>', {
    desc = 'Increase Width Of Current Window'
  })
  map('n', '<S-Right>', '<Cmd>vertical resize -4<CR>', {
    desc = 'Decrease Width Of Current Window'
  })
  map('n', '<A-=>', '<C-w>=', {
    desc = 'Make All Windows The Same Size'
  })
end

--- Control app, buffer and file behaviors
function M.control()
  -- buffer operations
  map('n', 'W', '<Cmd>w<CR>', {
    desc = 'Write Current Buffer To File'
  })
  map('n', 'Q', '<Cmd>qa<CR>', {
    desc = 'Quit Neovim (Close All Buffer)'
  })
  map('n', 'B', '<Cmd>bd<CR>', {
    desc = 'Close Current Buffer'
  })
  map('n', '<leader>ca', '<Cmd>%y+<CR>', {
    desc = 'Copy Current Buffer Into System Clipboard', silent = true
  })

  -- keep focus
  map('n', '<leader><CR>', '<Cmd>noh<CR>', {
    desc = 'Hide Highlight Temporarily', silent = true
  })
  map('n', '<leader>wl', '<Cmd>set wrap!<CR>', {
    desc = 'Toogle Line Wrap', silent = true
  })
  map('n', '<leader>n', '<Cmd>set nu!<CR>', {
    desc = 'Toggle Line Number', silent = true
  })
  map('n', '<leader>rn', '<Cmd>set rnu!<CR>', {
    desc = 'Toggle Relative Line Number', silent = true
  })
end

return M

