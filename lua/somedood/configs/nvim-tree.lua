return function()
    local g = vim.g
    g.nvim_tree_indent_markers = 1
    g.nvim_tree_highlight_opened_files = 1
    g.nvim_tree_add_trailing = 1
    g.nvim_tree_group_empty = 1
    g.nvim_tree_show_icons = {
        git = 0,
        folders = 1,
        files = 1,
        folder_arrows = 1,
    }

    require'nvim-tree'.setup {
        auto_reload_on_write = false,
        update_cwd = true,
        hijack_cursor = true,
        filters = { dotfiles = true },
        git = { ignore = true },
        view = { side = 'right' },
    }
end
