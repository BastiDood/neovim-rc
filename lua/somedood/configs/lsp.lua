local function on_lsp_attach(_, bufnr)
    local function buf_set_keymap(mode, combo, macro)
        vim.api.nvim_buf_set_keymap(bufnr, mode, combo, macro, { noremap = true, silent = true })
    end

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>')
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.diagnostic.open_float()<CR>')
    buf_set_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    buf_set_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    buf_set_keymap('n', '<space>fmt', '<cmd>lua vim.lsp.buf.formatting()<CR>')
end

return function()
    local caps = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local lsp = require'lspconfig'

    -- Simple Configurations
    lsp.clangd.setup { on_attach = on_lsp_attach, capabilities = caps } 
    lsp.cmake.setup { on_attach = on_lsp_attach, capabilities = caps } 
    lsp.emmet_ls.setup { on_attach = on_lsp_attach, capabilities = caps } 
    lsp.html.setup { on_attach = on_lsp_attach, capabilities = caps } 
    lsp.jsonls.setup { on_attach = on_lsp_attach, capabilities = caps } 
    lsp.tsserver.setup { on_attach = on_lsp_attach, capabilities = caps } 

    -- Advanced CSS Configuration
    local css_config = {
        validate = true,
        lint = {
            boxModel = 'warning',
            compatibleVendorPrefixes = 'warning',
            duplicateProperties = 'error',
            ieHack = 'error',
            important = 'warning',
            importStatement = 'warning',
            universalSelector = 'error',
            unknownVendorSpecificProperties = 'error',
            zeroUnits = 'error',
        },
    }
    lsp.cssls.setup {
        on_attach = on_lsp_attach,
        capabilities = caps,
        settings = {
            css = css_config,
            less = css_config,
            scss = css_config,
        },
    } 

    -- Advanced Deno Configuration
    lsp.denols.setup {
        on_attach = on_lsp_attach,
        capabilities = caps,
        init_options = { enable = true, lint = true },
    }

    -- Advanced Pyright Configuration
    lsp.pyright.setup {
        on_attach = on_lsp_attach,
        capabilities = caps,
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = 'workspace',
                    typeCheckingMode = 'strict',
                    useLibraryCodeForTypes = true,
                }
            }
        }
    }

    -- Advanced Rust Analyzer Configuration
    lsp.rust_analyzer.setup {
        on_attach = on_lsp_attach,
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = { enable = false },
            }
        }
    }
end
