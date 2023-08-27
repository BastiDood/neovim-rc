return {
    core = function()
        require'telescope'.setup {
            defaults = {
                use_less = true,
                file_sorter = require'telescope.sorters'.get_fzy_sorter,
                mappings = {
                    i = { [ '<esc>' ] = require'telescope.actions'.close },
                },
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
        }
    end,
    fzf = function()
        require'telescope'.load_extension('fzf')
    end,
    ui = function()
        require'telescope'.load_extension('ui-select')
    end,
}
