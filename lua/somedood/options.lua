-- Switch to Development Directory
vim.cmd('cd /Dev')

-- Indentation
vim.o.foldmethod = 'expr'
vim.o.foldexpr = [[nvim_treesitter#foldexpr()]]
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.smarttab = true

-- Performance Options
vim.o.lazyredraw = true

-- Text Rendering Options
vim.o.termguicolors = true
vim.o.encoding = 'UTF-8'
vim.o.wrap = true
vim.o.linebreak = true
vim.o.scrolloff = 5
vim.o.hlsearch = false

-- User Interface Options
vim.cmd('colorscheme edge')
vim.opt.completeopt:append({ 'menuone', 'preview' })
vim.o.mouse = 'n'
vim.o.showmode = false
vim.o.ruler = true
vim.o.tabpagemax = 5
vim.o.cursorline = true
vim.o.signcolumn = 'number'
vim.o.number = true
vim.o.relativenumber = true
vim.o.nu = true
vim.o.rnu = true
vim.o.splitbelow = true
vim.o.splitright = true

-- Miscellaneous
vim.opt.shortmess:append({ c = true })
vim.opt.clipboard:append({ 'unnamedplus' })
vim.o.hidden = true
vim.o.history = 500
vim.o.backup = false
vim.o.writebackup = false
