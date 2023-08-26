local g = vim.g
local o = vim.o

-- Neovide Configuration
g.neovide_input_use_logo = false
g.neovide_cursor_vfx_mode = 'torpedo'
g.neovide_cursor_vfx_lifetime = 1.0

-- Vim Globals
g.mapleader = ' '
g.netrw_liststyle = 3

-- Indentation
o.foldmethod = 'expr'
o.foldexpr = [[nvim_treesitter#foldexpr()]]
o.foldenable = false
o.autoindent = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.smarttab = true
o.breakindent = true

-- Performance Options
o.lazyredraw = true

-- Text Rendering Options
o.termguicolors = true
o.encoding = 'UTF-8'
o.wrap = true
o.linebreak = true
o.scrolloff = 5
o.hlsearch = false

-- User Interface Options
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect', 'preview' }
o.mouse = 'n'
o.showmode = false
o.ruler = true
o.tabpagemax = 5
o.cursorline = true
o.signcolumn = 'number'
o.number = true
o.relativenumber = true
o.nu = true
o.rnu = true
o.splitbelow = true
o.splitright = true

-- Miscellaneous
vim.opt.shortmess:append({ c = true })
o.smartcase = true
o.hidden = true
o.history = 500
o.backup = false
o.writebackup = false
