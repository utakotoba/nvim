--- @diagnostic disable: assign-type-mismatch

--- @type vim.pack.Spec
return {
  src = 'https://github.com/stevearc/conform.nvim.git',
  --- @type lz.n.Spec
  data = {
    lazy = true,
    event = 'BufWritePre',
    cmd = { 'ConformInfo' },
    after = function()
      --- @type conform.setupOpts
      local opts = {
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'ruff_format' },
        },
        default_format_opts = {
          lsp_format = 'fallback',
        },
        format_on_save = {
          timeout_ms = 500,
        },
      }
      require('conform').setup(opts)
    end,
  },
}
