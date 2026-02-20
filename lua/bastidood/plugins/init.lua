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
			config = require'bastidood.plugins.configs.edge'
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
			event = 'VeryLazy',
			opts = { },
		},
		{
			'nvim-mini/mini.files',
			version = false,
			dependencies = { 'nvim-mini/mini.icons' },
			keys = {
				{ '<leader>n', function() require'mini.files'.open() end, desc = 'Ope[n] mini.files' },
			},
			opts = { },
		},
		{
			'kylechui/nvim-surround',
			version = '*',
			event = 'VeryLazy',
			opts = { },
		},
		{
			'windwp/nvim-autopairs',
			event = 'InsertEnter',
			opts = { check_ts = true },
		},
  		{
			'folke/todo-comments.nvim',
			event = { 'BufReadPost', 'BufNewFile' },
			dependencies = { 'nvim-lua/plenary.nvim' },
			opts = { signs = false },
		},
		{
			'saghen/blink.cmp',
			event = { 'InsertEnter', 'CmdlineEnter' },
			version = '1.*',
			opts = {
				keymap = { preset = 'default' },
				sources = { default = { 'path' } },
				signature = { enabled = true },
			},
		},
		{
			'nvim-telescope/telescope.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim',
				'nvim-telescope/telescope-fzf-native.nvim',
				'nvim-telescope/telescope-ui-select.nvim',
			},
			-- Pre-emptive init for `telescope-ui-select` hooking into `vim.ui.select`,
			-- assuming LSPs are the main source of `vim.ui.select` via code actions.
			event = 'LspAttach',
			keys = {
				{
					'<C-f>',
					function() require'telescope.builtin'.current_buffer_fuzzy_find() end,
					desc = '[C-f] Fuzzy-search in current buffer',
				},
				{
					'<C-S-f>',
					function() require'telescope.builtin'.live_grep() end,
					desc = '[C-S-f] Search by grep',
				},
				{
					'<C-,>',
					function() require'telescope.builtin'.find_files { cwd = vim.fn.stdpath'config' } end,
					desc = '[C-,] Search in config directory',
				},
				{
					'<leader>ss',
					function() require'telescope.builtin'.builtin() end,
					desc = '[s]earch [s]elect Telescope',
				},
				{
					'<leader>sk',
					function() require'telescope.builtin'.keymaps() end,
					desc = '[s]earch [k]eymaps',
				},
				{
					'<leader>sw',
					function() require'telescope.builtin'.grep_string() end,
					mode = { 'n', 'v' },
					desc = '[s]earch current [w]ord',
				},
				{
					'<leader>sd',
					function() require'telescope.builtin'.diagnostics() end,
					desc = '[s]earch [d]iagnostics',
				},
				{
					'<leader>sr',
					function() require'telescope.builtin'.resume() end,
					desc = '[s]earch [r]esume',
				},
				{
					'<leader>s.',
					function() require'telescope.builtin'.oldfiles() end,
					desc = '[s]earch recent files ("." for repeat)',
				},
				{
					'<leader>sc',
					function() require'telescope.builtin'.commands() end,
					desc = '[s]earch [c]ommands',
				},
				{
					'<leader>?',
					function() require'telescope.builtin'.help_tags() end,
					desc = 'Search help',
				},
				{
					'<leader>ff',
					function() require'telescope.builtin'.find_files() end,
					desc = '[f]ind [f]iles',
				},
				{
					'<leader>fb',
					function() require'telescope.builtin'.buffers() end,
					desc = '[f]ind [b]uffers',
				},
				{
					'<leader>ft',
					function() require'telescope.builtin'.treesitter() end,
					desc = '[f]ind [t]reesitter',
				},
				{
					'<leader>fGf',
					function() require'telescope.builtin'.git_files() end,
					desc = '[f]ind [G]it [f]iles',
				},
				{
					'<leader>Gb',
					function() require'telescope.builtin'.git_branches() end,
					desc = '[f]ind [G]it [b]ranches',
				},
			},
			config = require'bastidood.plugins.configs.telescope',
		},
		{ 'nvim-telescope/telescope-ui-select.nvim' },
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'cmake -S.  -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
		},
		{
			'nvim-treesitter/nvim-treesitter',
			lazy = false,
			config = require'bastidood.plugins.configs.treesitter',
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
