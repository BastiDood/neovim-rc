return {
    core = function()
        require'telescope'.setup {
            defaults = {
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
            disable_devicons = false,
            use_less = true,
            pickers = {
                find_files = {
                    find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
                },
            },
            extensions = {
                fzy_native = {
                    override_generic_sorter = false,
                    override_file_sorter = true,
                }
            },
        }
    end,
    fzy = function()
        require'telescope'.load_extension('fzy_native')
    end,
}
