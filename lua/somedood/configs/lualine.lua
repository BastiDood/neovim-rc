return function()
    require'lualine'.setup {
        extensions = { 'nvim-tree', 'fugitive' },
        options = { theme = 'edge' },
    }
end
