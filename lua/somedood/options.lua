--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Show which line the cursor is on.
vim.opt.cursorline = true
vim.opt.scrolloff = 5

-- Gutter controls.
vim.opt.signcolumn = 'number'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.rnu = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode because it's already in the status line.
vim.opt.showmode = false

-- Indentation controls.
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = [[nvim_treesitter#foldexpr()]]
vim.opt.foldenable = false

-- Case-insensitive searching unless \C or one or more capital letters in the search term.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set highlight on search.
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', function() vim.cmd 'nohlsearch' end)

-- New splits should open in this manner.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- User Interface Options
vim.opt.shortmess:append { c = true }
vim.opt.lazyredraw = true

-- Convenience shortcuts for moving the focus from one window to another.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move Focus to the Left Window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move Focus to the Right Window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move Focus to the Lower Window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move Focus to the Upper Window' })

-- Storage Consumption Controls
vim.opt.history = 1024
vim.opt.backup = false
vim.opt.writebackup = false

-- Neovide Configuration
vim.g.neovide_input_use_logo = false
vim.g.neovide_cursor_vfx_mode = 'torpedo'
vim.g.neovide_cursor_vfx_lifetime = 1.0

-- Vim Globals
vim.g.netrw_liststyle = 3
