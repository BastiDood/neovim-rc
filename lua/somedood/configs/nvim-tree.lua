return function()
    require'nvim-tree'.setup {
        ignore_ft_on_setup = { '.vim', '.git', '.github', '.vscode', 'node_modules', 'target', 'build' },
        update_cwd = true,
        hijack_cursor = true,
        filters = { dotfiles = true },
        git = { ignore = true },
        view = { side = 'right' },
    }
end
