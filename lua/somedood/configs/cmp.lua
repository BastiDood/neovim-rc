local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return function()
    local cmp = require'cmp'
    cmp.setup {
        snippet = { expand = function(args) require'luasnip'.lsp_expand(args.body) end },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer', { keyword_length = 5 } },
            { name = 'path' },
        }),
        mapping = {
            ['<C-n>'] = cmp.mapping.select_prev_item(),
            ['<C-p>'] = cmp.mapping.select_next_item(),
            ['<C-Up>'] = cmp.mapping.scroll_docs(-4),
            ['<C-Down>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm {
                select = true,
                behavior = cmp.ConfirmBehavior.Replace,
            },
        },
    }
end
