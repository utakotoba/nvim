return {
  cmd = { 'emmylua_ls', '--editor=neovim' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.emmyrc.json',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  on_attach = function(client, _bufnr)
    -- disable semantic tokens for highlighting,
    -- since it introduces miss highlight in group:
    -- `@lsp.typemod.variable.static.lua`,
    -- tree-sitter only is fine.
    client.server_capabilities.semanticTokensProvider = nil
  end,
}
