function on_lsp_attach(client, bufnr)
    local function buf_set_keymap(mode, combo, macro)
        vim.api.nvim_buf_set_keymap(bufnr, mode, combo, macro, { noremap = true, silent = true })
    end

    -- Regular Keybindings
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>')
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    buf_set_keymap('n', '<Space>pd', '<cmd>lua vim.lsp.diagnostic.show_position_diagnostics()<CR>')
    buf_set_keymap('n', '<Space>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    buf_set_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    buf_set_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    buf_set_keymap('n', '<Space>fmt', '<cmd>lua vim.lsp.buf.formatting()<CR>')

    -- Telescope Integration
    buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
    buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>')
    buf_set_keymap('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>')
    buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>')
    buf_set_keymap('n', '<Space>ws', '<cmd>Telescope lsp_workspace_symbols<CR>')
    buf_set_keymap('n', '<Space>wd', '<cmd>Telescope lsp_workspace_diagnostics<CR>')
    buf_set_keymap('n', '<Space>ds', '<cmd>Telescope lsp_document_symbols<CR>')
    buf_set_keymap('n', '<Space>dd', '<cmd>Telescope lsp_document_diagnostics<CR>')
    buf_set_keymap('n', '<Space>ca', '<cmd>Telescope lsp_code_actions<CR>')

    return require'lsp-status'.on_attach(client, bufnr)
end

return function()
    local status = require'lsp-status'
    local lsp = require'lspconfig'

    -- Native LSP Diagnostics
    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
    })

    local caps = vim.tbl_extend('keep', require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities()), status.capabilities)

    -- Simple Configurations
    lsp.cmake.setup { on_attach = on_lsp_attach, capabilities = caps } 
    lsp.emmet_ls.setup { on_attach = on_lsp_attach, capabilities = caps } 
    lsp.html.setup { on_attach = on_lsp_attach, capabilities = caps } 
    lsp.jsonls.setup { on_attach = on_lsp_attach, capabilities = caps } 
    lsp.tsserver.setup { on_attach = on_lsp_attach, capabilities = caps } 

    -- Advanced Clangd Configuration
    lsp.clangd.setup {
        on_attach = on_lsp_attach,
        capabilities = capabilities,
        init_options = { clangdFileStatus = true },
        handlers = status.extensions.clangd.setup(),
    } 

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
        capabilities = caps,
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = { command = 'clippy' },
            },
        },
    }
end
