-- Kohane's neovim configurations
-- Mixtape!

-- disable built-in plugin loader,
-- since Neovim's built-in plugins are mostly unused
vim.go.loadplugins = false

-- explicitly enable lua loader
vim.loader.enable()

-- setup globals, options and plugins
require 'core'

-- call internal setup
require 'internal'
