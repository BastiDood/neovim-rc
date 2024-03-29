function on_lsp_attach(client, bufnr)
    local function buf_set_keymap(mode, combo, macro)
        vim.keymap.set(mode, combo, macro, { buffer = bufnr, noremap = true, silent = true })
    end
    local function diag_open_float(scope)
        return vim.diagnostic.open_float({ scope = scope })
    end

    -- Enable Omnifunc Integration
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Regular Keybindings
    buf_set_keymap('n', 'K', vim.lsp.buf.hover)
    buf_set_keymap('n', '<F2>', vim.lsp.buf.rename)
    buf_set_keymap('n', 'gD', vim.lsp.buf.declaration)
    buf_set_keymap('n', '<C-k>', vim.lsp.buf.signature_help)
    buf_set_keymap('n', '<Space>fmt', function() vim.lsp.buf.format { async = true } end)
    buf_set_keymap('n', '<Space>pd', function() diag_open_float('cursor') end)
    buf_set_keymap('n', '<Space>ld', function() diag_open_float('line') end)
    buf_set_keymap('n', 'g[', vim.diagnostic.goto_prev)
    buf_set_keymap('n', 'g]', vim.diagnostic.goto_next)
    buf_set_keymap('n', '<Space>ca', vim.lsp.buf.code_action)

    -- Telescope Integration
    local t = require'telescope.builtin'
    buf_set_keymap('n', '<Space>wd', t.diagnostics)
    buf_set_keymap('n', '<Space>dd', function() t.diagnostics({ bufnr = 0 }) end)
    buf_set_keymap('n', 'gd', t.lsp_definitions)
    buf_set_keymap('n', 'gi', t.lsp_implementations)
    buf_set_keymap('n', 'gt', t.lsp_type_definitions)
    buf_set_keymap('n', 'gr', t.lsp_references)
    buf_set_keymap('n', '<Space>ws', t.lsp_workspace_symbols)
    buf_set_keymap('n', '<Space>ds', t.lsp_document_symbols)
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
    local lsp = require'lspconfig'
    local caps = require'cmp_nvim_lsp'.default_capabilities()

    vim.diagnostic.config { severity_sort = true }

    -- Simple Configurations
    lsp.cmake.setup { on_attach = on_lsp_attach, capabilities = caps }
    lsp.emmet_ls.setup { on_attach = on_lsp_attach, capabilities = caps }
    lsp.gopls.setup { on_attach = on_lsp_attach, capabilities = caps }
    lsp.html.setup { on_attach = on_lsp_attach, capabilities = caps }
    lsp.nushell.setup { on_attach = on_lsp_attach, capabilities = caps }
    lsp.svelte.setup { on_attach = on_lsp_attach, capabilities = caps }
    lsp.svls.setup { on_attach = on_lsp_attach, capabilities = caps, single_file_support = true }

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
        autostart = false,
        on_attach = on_lsp_attach,
        capabilities = caps,
        root_dir = lsp.util.root_pattern('deno.json'),
        settings = {
            deno = {
                enable = true,
                lint = true,
                unstable = true,
            },
        },
    }

    -- Advanced JSON Configuration
    lsp.jsonls.setup {
        on_attach = on_lsp_attach,
        capabilities = caps,
        settings = {
            json = {
                schemas = require'schemastore'.json.schemas {
                    select = {
                        'package.json',
                        'jsconfig.json',
                        'tsconfig.json',
                        'CMake Presets',
                    },
                }
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
            vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufEnter', 'BufWinEnter', 'TabEnter', 'BufWritePost' }, {
                pattern = '*.rs',
                callback = on_inlay_hint,
            })
            on_lsp_attach(client, bufnr)
        end,
        capabilities = caps,
        settings = {
            ['rust-analyzer'] = {
                cargo = { autoreload = true },
                imports = { prefer = { no = { std = true } } },
            },
        },
    }

    -- Advanced TexLab Configuration
    lsp.texlab.setup {
        on_attach = on_lsp_attach,
        capabilities = capabilities,
        filetypes = { 'tex', 'bib', 'plaintex' },
        settings = {
            texlab = {
                build = {
                    executable = 'tectonic',
                    args = { '-X', 'build' },
                },
            },
        },
    }

    -- Advanced TypeScript Server Configuration
    lsp.tsserver.setup {
        autostart = false,
        on_attach = on_lsp_attach,
        capabilities = caps,
        root_dir = lsp.util.root_pattern('package.json'),
    }

    -- Advanced Zig Language Server Configuration
    lsp.zls.setup {
        autostart = true,
        on_attach = on_lsp_attach,
        capabilities = caps,
    }
end
