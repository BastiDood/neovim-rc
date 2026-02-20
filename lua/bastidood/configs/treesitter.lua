return function()
	local filetypes = {
		'bash',
		'c',
		'comment',
		'cpp',
		'css',
		'dockerfile',
		'diff',
		'git_rebase',
		'gitcommit',
		'gitignore',
		'html',
		'javascript',
		'jsdoc',
		'lua',
		'markdown',
		'markdown_inline',
		'nu',
		'python',
		'rust',
		'sql',
		'svelte',
		'toml',
		'tsx',
		'typescript',
		'vim',
		'vimdoc',
		'yaml',
	}

	-- Ensure grammars are installed on startup. No-op if already installed.
	require'nvim-treesitter'.install(filetypes)

	-- Enable syntax highlighting for the detected file types.
	vim.api.nvim_create_autocmd('FileType', {
		pattern = filetypes,
		callback = function() vim.treesitter.start() end,
	})

	-- Enable experimental folds support.
	vim.wo[0][0].foldexpr = [[v:lua.vim.treesitter.foldexpr()]]
	vim.wo[0][0].foldmethod = 'expr'

	-- Enable experimental indentation support.
	vim.bo.indentexpr = [[v:lua.require'nvim-treesitter'.indentexpr()]]
end
