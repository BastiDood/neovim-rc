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
end
