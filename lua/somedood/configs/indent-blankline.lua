return function()
    require'indent_blankline'.setup {
        context_patterns = {
            'namespace',
            'module',
            'class',
            'method',
            'function',
            'if',
            'table',
            'while',
            'for',
            'loop',
        },
        filetype_exclude = {
            'fugitive',
            'help',
            'packer',
            'terminal',
            'NvimTree',
            'TelescopePrompt',
        },
        show_current_context = true,
        show_current_context_start = true,
        use_treesitter = true,
    }

    -- HACK: Apparently, VimScript's `extend` function doesn't detect that `{}` is a table.
    local yellow = vim.fn['edge#get_palette']('default', { empty = {} }).yellow[1];
    vim.cmd(string.format('highlight IndentBlanklineContextChar gui=nocombine guifg=%s', yellow))
    vim.cmd(string.format('highlight IndentBlanklineContextStart gui=underline,bold guisp=%s', yellow))
end
