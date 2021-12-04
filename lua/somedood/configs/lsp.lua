return function()
    local caps = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local lsp = require'lspconfig'

    lsp.clangd.setup {
        cmd = { 'clangd', '--background-index' },
        capabilities = caps,
    } 
end
