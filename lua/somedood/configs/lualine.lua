return function()
    require'lualine'.setup {
        sections = { lualine_c = { 'filename', 'g:coc_status' } },
        extensions = { 'nvim-tree', 'fugitive' },
        options = { theme = 'edge' },
    }
end
