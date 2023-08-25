return function()
    local g = vim.g
    g.edge_enable_italic = 0
    g.edge_disable_italic_comment = 1
    g.edge_diagnostic_virtual_text = 'colored'
    vim.cmd('colorscheme edge')
end
