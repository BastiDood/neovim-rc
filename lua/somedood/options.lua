local o = vim.o

-- Switch to Development Directory
vim.cmd('cd /Dev')

-- Indentation
o.foldmethod = 'expr'
o.foldexpr = [[nvim_treesitter#foldexpr()]]
o.autoindent = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.smarttab = true

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
vim.cmd('colorscheme edge')
vim.opt.completeopt:append({ 'menuone', 'preview' })
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
vim.opt.clipboard:append({ 'unnamedplus' })
o.hidden = true
o.history = 500
o.backup = false
o.writebackup = false
