-- neovim options
local opt = vim.opt

-- system terminal emulator
opt.title = true
opt.termguicolors = true

-- ui appearance & layout
opt.number = true
opt.cursorline = true
opt.cursorlineopt = 'number'
opt.signcolumn = 'yes'
opt.conceallevel = 0
opt.wrap = false
opt.scrolloff = 16
opt.sidescrolloff = 12
opt.pumblend = 12
opt.winblend = 32
opt.splitright = true
opt.list = true
opt.listchars = {}
opt.fillchars = {}

-- indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true

-- input & key behavior
opt.timeout = false
opt.wildmenu = true

-- search
opt.ignorecase = true
opt.smartcase = true

-- file
opt.autoread = true
opt.undofile = true
opt.confirm = true

-- editing
opt.virtualedit = 'block'
opt.spell = false

-- performance
opt.ttyfast = true
opt.updatetime = 100
opt.lazyredraw = true
opt.redrawtime = 1500

