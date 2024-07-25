return function()
    local snip = require'luasnip'
    local cmp = require'cmp'
    cmp.setup {
        view = { entries = 'native' },
        completion = { completeopt = 'menu,menuone,noinsert,preview' },
        snippet = { expand = function(args) snip.lsp_expand(args.body) end },
        sources = cmp.config.sources {
            { name = 'nvim_lsp', max_item_count = 15 },
            { name = 'luasnip', max_item_count = 5 },
            { name = 'buffer', max_item_count = 10, keyword_length = 4 },
            { name = 'path', max_item_count = 5 },
        },
        mapping = cmp.mapping.preset.insert {
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-S-Y>'] = cmp.mapping.abort(),
            ['<C-y>'] = cmp.mapping.confirm { select = true },
            ['<C-Up>'] = cmp.mapping.scroll_docs(-4),
            ['<C-Down>'] = cmp.mapping.scroll_docs(4),
            ['<C-l>'] = cmp.mapping(function()
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                end
            end,
            { 'i', 's' }),
            ['<C-h>'] = cmp.mapping(function()
                if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { 'i', 's' }),
        },
    }
end
