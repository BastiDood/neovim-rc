function on_lsp_attach(client, bufnr)
    local function buf_set_keymap(mode, combo, macro)
        vim.api.nvim_buf_set_keymap(bufnr, mode, combo, macro, { noremap = true, silent = true })
    end

    -- Enable Omnifunc Integration
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

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
    buf_set_keymap('n', '<Space>wd', '<cmd>Telescope diagnostics<CR>')
    buf_set_keymap('n', '<Space>dd', '<cmd>Telescope diagnostics bufnr=0<CR>')
    buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
    buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>')
    buf_set_keymap('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>')
    buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>')
    buf_set_keymap('n', '<Space>ws', '<cmd>Telescope lsp_workspace_symbols<CR>')
    buf_set_keymap('n', '<Space>ds', '<cmd>Telescope lsp_document_symbols<CR>')
    buf_set_keymap('n', '<Space>ca', '<cmd>Telescope lsp_code_actions<CR>')

    return require'lsp-status'.on_attach(client, bufnr)
end

function on_inlay_hint()
    require'lsp_extensions'.inlay_hints {
        highlight = 'Comment',
        prefix = ' ▶ ',
        aligned = false,
        only_current_line = false,
        enabled = { 'ChainingHint' }
    }
end

return function()
    local status = require'lsp-status'
    local lsp = require'lspconfig'
    local caps = vim.tbl_extend('keep', require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities()), status.capabilities)

    vim.diagnostic.config({ severity_sort = true })

    -- Simple Configurations
    lsp.cmake.setup { on_attach = on_lsp_attach, capabilities = caps } 
    lsp.emmet_ls.setup { on_attach = on_lsp_attach, capabilities = caps } 
    lsp.html.setup { on_attach = on_lsp_attach, capabilities = caps } 
    lsp.jsonls.setup { on_attach = on_lsp_attach, capabilities = caps } 

    -- Advanced Clangd Configuration
    lsp.clangd.setup {
        cmd = {
            'clangd',
            '--clang-tidy',
            '--background-index',
            '--all-scopes-completion',
            '--completion-style=detailed',
            '--header-insertion=iwyu',
            '--enable-config',
        },
        on_attach = on_lsp_attach,
        capabilities = caps,
        init_options = {
            clangdFileStatus = true,
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true,
        },
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
        root_dir = lsp.util.root_pattern('deno.json'),
        settings = {
            deno = {
                enable = true,
                lint = true,
                config = 'deno.json',
                importMap = 'imports.json',
            },
        },
    }

    -- Advanced Pyright Configuration
    lsp.pyright.setup {
        on_attach = on_lsp_attach,
        capabilities = caps,
        settings = {
            python = {
                analysis = {
                    autoImportCompletions = true,
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
        on_attach = function(client, bufnr)
            vim.cmd[[autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua on_inlay_hint()]]
            on_lsp_attach(client, bufnr)
        end,
        capabilities = caps,
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = { command = 'clippy' },
            },
        },
    }

    -- Advanced SVLS Configuration
    lsp.svls.setup {
        on_attach = on_lsp_attach,
        capabilities = capabilities,
        root_dir = lsp.util.root_pattern('.git'),
    }

    -- Advanced TypeScript Server Configuration
    lsp.tsserver.setup {
        autostart = false, -- Deno LSP takes precedence...
        on_attach = on_lsp_attach,
        capabilities = caps,
        root_dir = lsp.util.root_pattern('package.json'),
    }
end
