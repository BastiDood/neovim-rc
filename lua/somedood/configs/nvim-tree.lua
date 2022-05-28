return function()
    require'nvim-tree'.setup {
        auto_reload_on_write = false,
        update_cwd = true,
        hijack_cursor = true,
        filters = { dotfiles = true },
        renderer = {
            add_trailing = true,
            group_empty = true,
            highlight_opened_files = 'icon',
            indent_markers = { enable = true },
            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = false,
                }
            },
        },
        git = { ignore = true },
        view = { side = 'right' },
    }
end
