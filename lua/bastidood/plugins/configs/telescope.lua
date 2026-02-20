return function()
	local telescope = require'telescope'

	telescope.setup {
		defaults = {
			use_less = true,
			path_display = { 'filename_first', 'truncate' },
			file_sorter = require'telescope.sorters'.get_fzy_sorter,
			mappings = { i = { [ '<esc>' ] = require'telescope.actions'.close } },
			vimgrep_arguments = {
				'rg',
				'--color=never',
				'--no-heading',
				'--with-filename',
				'--line-number',
				'--column',
				'--smart-case',
				'--trim',
			},
		},
		pickers = {
			find_files = {
				find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
			},
		},
        extensions = {
        	['ui-select'] = { require'telescope.themes'.get_dropdown() },
        },
	}

	-- Only load the extensions that are installed.
	pcall(telescope.load_extension, 'fzf')
	pcall(telescope.load_extension, 'ui-select')

	local builtin = require 'telescope.builtin'
	vim.keymap.set('n', '<C-f>', builtin.current_buffer_fuzzy_find, { desc = '[C-f] Fuzzy-search in current buffer' })
	vim.keymap.set('n', '<C-S-f>', builtin.live_grep, { desc = '[C-S-f] Search by grep' })
	vim.keymap.set('n', '<C-,>', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[C-,] Search in config directory' })

	-- Kickstart.nvim
	vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[s]earch [s]elect Telescope' })
	vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[s]earch [k]eymaps' })
	vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[s]earch current [w]ord' })
	vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
	vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[s]earch [r]esume' })
	vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[s]earch Recent Files ("." for repeat)' })
	vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[s]earch [c]ommands' })

	-- Custom Keymaps
	vim.keymap.set('n', '<leader>?', builtin.help_tags, { desc = 'Search help' })
	vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[f]ind [f]iles' })
	vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[f]ind [b]uffers' })
	vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = '[f]ind [t]reesitter' })
	vim.keymap.set('n', '<leader>fGf', builtin.git_files, { desc = '[f]ind [G]it [f]iles' })
	vim.keymap.set('n', '<leader>Gb', builtin.git_branches, { desc = '[f]ind [G]it [b]ranches' })
end
