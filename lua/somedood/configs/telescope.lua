return {
    core = function()
        require'telescope'.setup {
            defaults = {
                file_sorter = require'telescope.sorters'.get_fzy_sorter,
                mappings = {
                    i = { [ '<esc>' ] = require'telescope.actions'.close },
                },
            },
            disable_devicons = false,
            use_less = true,
            pickers = { file_browser = { disable_devicons = true } },
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
