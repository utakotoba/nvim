local map = vim.keymap.set

--- Helper function to set rhs a EX command
--- @param command string EX coammd to run
--- @return string built rhs value for keymap
local function ex(command)
  return '<Cmd>' .. command .. '<CR>'
end

local M = {}

function M.base()
  -- replace built-in up and down
  map({ 'n', 'x' }, 'k', 'v:count == 0 ? "gk" : "k"', { desc = 'Up', expr = true, silent = true })
  map({ 'n', 'x' }, '<Down>', 'v:count == 0 ? "gk" : "k"', { desc = 'Up', expr = true, silent = true })
  map({ 'n', 'x' }, 'j', 'v:count == 0 ? "gj" : "j"', { desc = 'Down', expr = true, silent = true })
  map({ 'n', 'x' }, '<Up>', 'v:count == 0 ? "gj" : "j"', { desc = 'Down', expr = true, silent = true })

  -- insert mode cursor move
  -- `noremap` -> true, cursor move in insert mode does not use
  -- the same behaviors like above in normal mode
  map('i', '<C-k>', '<Up>', { desc = 'Move Up', noremap = true })
  map('i', '<C-j>', '<Down>', { desc = 'Move Down', noremap = true })
  map('i', '<C-h>', '<Left>', { desc = 'Move Left', noremap = true })
  map('i', '<C-l>', '<Right>', { desc = 'Move Right', noremap = true })

  -- move lines
  map('n', '<A-k>', ex('execute "move .-" . (v:count1 + 1)') .. '==', { desc = 'Move Lines Up' })
  map('n', '<A-j>', ex('execute "move .+" . v:count1') .. '==', { desc = 'Move Lines Down' })

  -- buffer operation
  map('n', 'W', ex('w'), { desc = 'Write File' })
  map('n', 'Q', ex('q'), { desc = 'Quit Neovim' })
  map('n', 'B', ex('bd'), { desc = 'Delete Current Buffer' })
end

return M

