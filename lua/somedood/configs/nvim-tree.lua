return function()
    require'nvim-tree'.setup {
        auto_reload_on_write = false,
        update_cwd = true,
        hijack_cursor = true,
        filters = { dotfiles = true },
        renderer = {
            add_trailing = true,
            group_empty = true,
            indent_markers = { enable = true },
            icons = {
                show = {
                    file = false,
                    folder = false,
                    folder_arrow = false,
                    git = false,
                    modified = false,
                },
            },
        },
        git = { ignore = true },
        view = { side = 'right' },
    }
end
