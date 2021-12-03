return function()
    require'indent_blankline'.setup {
        context_patterns = { 'class', 'method', 'function', 'if' },
        filetype_exclude = {
            'fugitive',
            'packer',
            'terminal',
            'NvimTree',
            'TelescopePrompt',
        },
        indent_level = 4,
        show_current_context = true,
        show_current_context_start = true,
        use_treesitter = true,
    }
end
