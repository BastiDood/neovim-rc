local lazypath = vim.fn.stdpath'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'--branch=stable',
		'https://github.com/folke/lazy.nvim.git',
		lazypath,
	}
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out, 'WarningMsg' },
			{ '\nPress any key to exit...', 'WarningMsg' },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Define plugins.
require'lazy'.setup {
	spec = {
		{
			'sainnhe/edge',
			priority = 1000,
			config = require'bastidood.configs.edge'
		},
		{
			'nvim-mini/mini.statusline',
			version = false,
			opts = { use_icons = false, set_vim_settings = false },
		},
		{
			'lukas-reineke/indent-blankline.nvim',
			event = { 'BufReadPost', 'BufNewFile' },
			main = 'ibl', opts = { },
		},
		{
			'NMAC427/guess-indent.nvim',
			event = { 'BufReadPost', 'BufNewFile' },
			opts = { },
		},
		{
			'nvim-mini/mini.icons',
			version = false,
			opts = { style = 'ascii' },
		},
		{
			'nvim-mini/mini.ai',
			version = false,
			event = 'InsertEnter',
			opts = { },
		},
		{
			'nvim-mini/mini.files',
			version = false,
			dependencies = { 'nvim-mini/mini.icons' },
			opts = require'bastidood.configs.mini.files',
		},
		{
			'kylechui/nvim-surround',
			version = '*',
			event = 'InsertEnter',
			opts = { },
		},
		{
			'windwp/nvim-autopairs',
			event = 'InsertEnter',
			opts = { check_ts = true },
		},
  		{
			'folke/todo-comments.nvim',
			event = 'VimEnter',
			dependencies = { 'nvim-lua/plenary.nvim' },
			opts = { signs = false },
		},
		{
			'saghen/blink.cmp',
			event = 'VimEnter',
			version = '1.*',
			opts = { keymap = { preset = 'default' } },
			sources = { default = { 'path' } },
      		signature = { enabled = true },
		},
		{
			'nvim-telescope/telescope.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim',
				'nvim-telescope/telescope-fzf-native.nvim',
				'nvim-telescope/telescope-ui-select.nvim',
			},
			config = require'bastidood.configs.telescope',
		},
		{ 'nvim-telescope/telescope-ui-select.nvim' },
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'cmake -S.  -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
		},
		{
			'nvim-treesitter/nvim-treesitter',
			lazy = false,
			config = require'bastidood.configs.treesitter',
			build = ':TSUpdate',
		},
	},
	install = { colorscheme = { 'edge' } },
	change_detection = { enabled = false },
	ui = {
		icons = {
			cmd = '⌘',
			config = '🛠',
			event = '📅',
			favorite = '❤',
			ft = '📂',
			init = '⚙',
			import = '📦',
			keys = '🗝',
			lazy = '💤',
			plugin = '🔌',
			runtime = '💻',
			require = '🌙',
			source = '📄',
			start = '🚀',
			task = '📌',
			list = { '=>>', '==>', '->>', '-->', '~~>' },
		},
	},
	performance = {
		rtp = {
			disabled_plugins = {
				'editorconfig',
				'gzip',
				'tarPlugin',
				'zipPlugin',
				'tohtml',
				'tutor',
				'netrwPlugin',
				'shada',
				'spellfile',
				'rplugin',
			},
		},
	},
}
