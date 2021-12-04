return function()
    local caps = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local lsp = require'lspconfig'

    -- Simple Configurations
    lsp.clangd.setup { capabilities = caps } 
    lsp.cmake.setup { capabilities = caps } 
    lsp.emmet_ls.setup { capabilities = caps } 
    lsp.html.setup { capabilities = caps } 
    lsp.jsonls.setup { capabilities = caps } 
    lsp.tsserver.setup { capabilities = caps } 

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
        capabilities = caps,
        settings = {
            css = css_config,
            less = css_config,
            scss = css_config,
        },
    } 

    -- Advanced Deno Configuration
    lsp.denols.setup {
        capabilities = caps,
        init_options = { enable = true, lint = true },
    }

    -- Advanced Pyright Configuration
    lsp.pyright.setup {
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
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = { enable = false },
            }
        }
    }
end
