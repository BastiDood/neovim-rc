return function()
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
            -- Enable Omnifunc completion for the buffer.
            vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Map buffer-level bindings in normal mode.
            local map = function(keys, func, desc)
                vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
            end

            -- Telescope Integration
            map('gd', require'telescope.builtin'.lsp_definitions, 'Go to Definition')
            map('gr', require'telescope.builtin'.lsp_references, 'Go to References')
            map('gI', require'telescope.builtin'.lsp_implementations, 'Go to Implementation')
            map('<leader>td', require'telescope.builtin'.lsp_type_definitions, 'Type Definition')
            map('<leader>ds', require'telescope.builtin'.lsp_document_symbols, 'Document Symbols')
            map('<leader>ws', require'telescope.builtin'.lsp_workspace_symbols, 'Workspace Symbols')
            map('<leader>wd', require'telescope.builtin'.diagnostics, 'Workspace Diagnostics')

            -- Native LSP Integration
            map('gD', vim.lsp.buf.declaration, 'Go to Declaration')
            map('<F2>', vim.lsp.buf.rename, 'Rename')
            map('K', vim.lsp.buf.hover, 'Show Documentation')
            map('<C-k>', vim.lsp.buf.signature_help, 'Show Signature Help')
            map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
            map('<leader>fmt', function() vim.lsp.buf.format { async = true } end, 'Format Code')

            -- Native Diagnostics Integration
            map('g[', vim.diagnostic.goto_prev, 'Go to Previous Diagnostic')
            map('g]', vim.diagnostic.goto_next, 'Go to Next Diagnostic')
            map('<leader>pd', function() vim.diagnostic.open_float { scope = 'cursor' } end, 'Show Diagnostics at Position')
            map('<leader>ld', function() vim.diagnostic.open_float { scope = 'line' } end, 'Show Diagnostics at Line')

            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client then
                if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    -- Highlight References at Cursor
                    map('<leader>hr', vim.lsp.buf.document_highlight, 'Highlight References at Cursor')
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })
                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end
                if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    -- Inlay Hints
                    map('<leader>ih', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, 'Toggle Inlay Hints')
                end
            end
        end,
    })

    local css = {
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

    local servers = {
        basedpyright = {
            settings = {
                python = {
                    analysis = {
                        autoImportCompletions = true,
                        autoSearchPaths = true,
                        diagnosticMode = 'workspace',
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        },
        clangd = {
            cmd = {
                'clangd',
                '--clang-tidy',
                '--background-index',
                '--all-scopes-completion',
                '--completion-style=detailed',
                '--header-insertion=iwyu',
                '--enable-config',
            },
            init_options = {
                clangdFileStatus = true,
                usePlaceholders = true,
                completeUnimported = true,
                semanticHighlighting = true,
            },
        },
        cmake = { },
        cssls = {
            settings = {
                css = css,
                less = css,
                scss = css,
            },
        },
        denols = {
            autostart = false,
            root_dir = require'lspconfig'.util.root_pattern('deno.json'),
            settings = { deno = { lint = true, unstable = true } },
        },
        emmet_ls = { },
        gopls = {
            settings = {
                gopls = {
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                },
            },
        },
        html = { },
        jsonls = {
            settings = {
                json = {
                    validate = { enable = true },
                    schemas = require'schemastore'.json.schemas {
                        select = {
                            '.eslintrc',
                            '.htmlhintrc',
                            'CMake Presets',
                            'Deno Config (deno.json)',
                            'package.json',
                            'prettierrc.json',
                            'tsup',
                            'Stylelint (.stylelintrc)',
                        },
                    },
                },
            },
        },
        marksman = { },
        rust_analyzer = {
            settings = {
                ['rust-analyzer'] = {
                    cargo = { autoreload = true },
                    imports = { prefer = { no = { std = true } } },
                },
            },
        },
        svelte = {
            on_attach = function(client, bufnr)
                -- https://github.com/neovim/nvim-lspconfig/issues/725#issuecomment-1837509673
                vim.api.nvim_create_autocmd('BufWritePost', {
                    pattern = { '*.js', '*.ts' },
                    callback = function(ctx)
                        client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
                    end,
                })
            end,
        },
        tailwindcss = { },
        wgsl_analyzer = { },
        zls = { autostart = true },
    }

    require'mason-tool-installer'.setup {
        ensure_installed = vim.tbl_keys(servers or { }),
        integrations = { ['mason-lspconfig'] = true },
    }

    local caps = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require'cmp_nvim_lsp'.default_capabilities())
    require'mason-lspconfig'.setup {
        handlers = {
            function(server_name)
                local server = servers[server_name] or { }
                server.capabilities = vim.tbl_deep_extend('force', {}, caps, server.capabilities or { })
                require'lspconfig'[server_name].setup(server)
            end,
        },
    }
end
