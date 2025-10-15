local map = vim.keymap.set

local M = {}

function M.lsp()
  -- common lsp functionalities
  map('n', '<localleader>r', '<Cmd>FzfLua lsp_references<CR>', {
    desc = 'Check LSP Refereneces',
    silent = true,
  })
  map('n', '<localleader>d', '<Cmd>FzfLua lsp_definitions<CR>', {
    desc = 'Check LSP Definitions',
    silent = true,
  })
  map('n', '<localleader>c', '<Cmd>FzfLua lsp_declarations<CR>', {
    desc = 'Check LSP Declarations',
    silent = true,
  })
  map('n', '<localleader>t', '<Cmd>FzfLua lsp_typedefs<CR>', {
    desc = 'Check LSP Type Definitions',
    silent = true,
  })
  map('n', '<localleader>s', '<Cmd>FzfLua lsp_implementations<CR>', {
    desc = 'Check LSP Implementations',
    silent = true,
  })
  map('n', '<localleader>ic', '<Cmd>FzfLua lsp_incoming_calls<CR>', {
    desc = 'Check LSP Incoming Calls',
    silent = true,
  })
  map('n', '<localleader>oc', '<Cmd>FzfLua lsp_outgoing_calls<CR>', {
    desc = 'Check LSP Outgoing Calls',
    silent = true,
  })
  map('n', '<localleader>a', '<Cmd>FzfLua lsp_code_actions<CR>', {
    desc = 'Check LSP Code Actions',
    silent = true,
  })
end

return M
