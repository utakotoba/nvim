local helper = require 'internal.stl.base'

local M = {}

--- Space character segment
function M.space()
  return helper.create_provider('space', ' ', {
    background = 'NONE',
    foreground = 'NONE',
  })
end

--- Separator character segment
function M.separator()
  return helper.create_provider('space', ' / ', {
    background = 'NONE',
    foreground = 'NONE',
  })
end

--- Lookup map to convert mode abbreviation for display
local mode_lookup = {
  -- normal mode and its variants
  ['n'] = 'Normal',
  ['no'] = 'O-Pend',
  -- the following n-related modes are actually too fast to see
  ['nov'] = 'O-Pend',
  ['noV'] = 'O-Pend',
  ['no\x16'] = 'O-Pend',
  -- operation pending (rarely occurred)
  ['niI'] = 'Ins-Pend',
  ['niR'] = 'Repl-Pend',
  ['niV'] = 'Repl-Pend',
  ['nt'] = 'N-Term',
  ['ntT'] = 'N-Term',
  ['n?'] = 'N-Confirm',

  -- insert mode and its variants
  ['i'] = 'Insert',
  ['ic'] = 'Insert',
  ['ix'] = 'Insert',

  -- replace mode and its variants
  ['R'] = 'Replace',
  ['Rc'] = 'Replace',
  ['Rx'] = 'Replace',
  ['Rv'] = 'V-Repl',
  ['Rvc'] = 'V-Repl',
  ['Rvx'] = 'V-Repl',
  ['R?'] = 'N-Confirm',

  -- visual mode and its variants
  ['v'] = 'Visual',
  ['vs'] = 'Visual',
  ['V'] = 'V-Line',
  ['Vs'] = 'V-Line',
  ['\x16'] = 'V-Block',
  ['\x16s'] = 'V-Block',

  -- select mode and its variants
  ['s'] = 'Select',
  ['S'] = 'S-Line',
  ['\x13'] = 'S-Block',

  -- command mode and its variants
  ['c'] = 'Command',
  ['cv'] = 'Ex',
  ['ce'] = 'Ex',

  -- terminal mode and its variants
  ['t'] = 'Terminal',
  ['r'] = 'Enter',
  ['rm'] = 'More',
  ['r?'] = 'Confirm',
  ['!'] = 'Shell',
}

--- Mode name segment
function M.modeinfo()
  local attr = helper.stl_attr 'StatusLineMode'
  -- set info text style
  attr.bold = true
  attr.italic = true

  return helper.create_provider(
    'modeinfo',
    function()
      local mode = vim.api.nvim_get_mode().mode
      return mode_lookup[mode]
        -- fallback to the first letter, if a complex state found
        or mode_lookup[string.sub(mode, 1, 1)]
        -- Placeholder if nothing match
        or 'Unknown'
    end, -- manually convert to display name
    attr,
    { 'ModeChanged', 'BufEnter', 'TermLeave' },
    'Normal' -- default is always normal mode
  )
end

--- File name segment
function M.filename()
  local attr = helper.stl_attr 'StatusLineFileInfo'
  attr.italic = true -- set italic filename

  return helper.create_provider(
    'filepath',
    '%t', -- file name only
    attr,
    { 'BufEnter' } -- change when every buffer enter
  )
end

return M
