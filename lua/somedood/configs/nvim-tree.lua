return function()
    require'nvim-tree'.setup {
        update_cwd = true,
        hijack_cursor = true,
        filters = { dotfiles = true },
        git = { ignore = true },
        view = { side = 'right' },
    }
end
