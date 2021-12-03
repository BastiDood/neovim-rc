return function()
    require'indent_blankline'.setup {
        context_patterns = {
            'class',
            'method',
            'function',
            'if',
            'table',
        },
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

    local yellow = vim.fn['edge#get_palette']('default').yellow[1];
    vim.cmd(string.format('highlight IndentBlanklineContextChar gui=nocombine guifg=%s', yellow))
    vim.cmd(string.format('highlight IndentBlanklineContextStart gui=underline guisp=%s', yellow))
end
