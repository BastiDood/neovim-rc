return function()
    require'lualine'.setup {
        sections = { lualine_c = { 'filename', "require'lsp-status'.status()" } },
        extensions = { 'nvim-tree', 'fugitive' },
        options = { theme = 'edge' },
    }
end
