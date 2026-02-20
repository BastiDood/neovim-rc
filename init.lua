-- <Space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- In this house, we use JetBrains Mono.
vim.g.have_nerd_font = false

-- Netrw Configuration
vim.g.netrw_liststyle = 3

-- Neovide Configuration
vim.g.neovide_input_use_logo = false
vim.g.neovide_cursor_vfx_mode = 'torpedo'
vim.g.neovide_cursor_vfx_lifetime = 1.0
vim.g.neovide_floating_shadow = false
vim.g.neovide_floating_blur_amount_x = 0.0
vim.g.neovide_floating_blur_amount_y = 0.0

-- Editor Gutter Options
vim.o.number = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.nu = true
vim.o.rnu = true
vim.o.signcolumn = 'yes'
vim.o.scrolloff = 5
vim.opt.laststatus = 3

-- Cursor Options
vim.o.mouse = 'a'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.cursorline = true

-- Split Controls
vim.o.splitright = true
vim.o.splitbelow = true

-- Indentation Controls
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Case-insensitive searching unless \C or one or more capital letters in the search term.
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.inccommand = 'split'

-- Redundant: it's already in the status line
vim.o.showmode = false

-- Ask for confirmation about destructive actions.
vim.o.confirm = true

vim.diagnostic.config {
	update_in_insert = false,
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = vim.diagnostic.severity.ERROR },
	virtual_text = true, -- Text shows up at the end of the line
	virtual_lines = false, -- Text shows up underneath the line, with virtual lines
	jump = { float = true },
}

require'bastidood.keybinds'
require'bastidood.plugins'
