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
    '.git',
  },
}

