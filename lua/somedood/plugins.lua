function plugins(use)
    -- Plugin Manager
    use 'wbthomason/packer.nvim'

    -- Editor Theming
    use 'sainnhe/edge'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require'lualine'.setup {
                options = { theme = 'edge' },
                sections = { lualine_c = { 'filename', 'g:coc_status' } },
                disabled_filetypes = { 'NvimTree' },
            }
        end,
    }

    -- Language Support
    use { 'rust-lang/rust.vim', ft = 'rust' }
    use { 'plasticboy/vim-markdown', ft = 'markdown' }

    -- Language Server Protocol
    use { 'neoclide/coc.nvim', branch = 'release' }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
            require'telescope'.setup {
                defaults = {
                    file_sorter = require'telescope.sorters'.get_fzy_sorter,
                    mappings = {
                        i = { [ '<esc>' ] = require'telescope.actions'.close },
                    },
                },
                disable_devicons = false,
                use_less = true,
                pickers = { file_browser = { disable_devicons = true } },
                extensions = {
                    fzy_native = {
                        override_generic_sorter = false,
                        override_file_sorter = true,
                    }
                },
            }
        end,
    }
    use {
        'nvim-telescope/telescope-fzy-native.nvim',
        requires = 'nvim-telescope/telescope.nvim',
        config = function() require'telescope'.load_extension('fzy_native') end,
    }
    use {
        'fannheyward/telescope-coc.nvim',
        requires = 'nvim-telescope/telescope.nvim',
        config = function() require'telescope'.load_extension('coc') end,
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
                indent = { enable = true },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
    }

    -- Miscellaneous
    use {
        'kyazdani42/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        config = function()
            require'nvim-tree'.setup {
                ignore_ft_on_setup = { '.vim', '.git', '.github', '.vscode', 'node_modules', 'target', 'build' },
                update_cwd = true,
                hijack_cursor = true,
                filters = { dotfiles = true },
                git = { ignore = true },
                view = { side = 'right' },
            }
        end,
    }
    use 'tpope/vim-fugitive'
end

return require'packer'.startup(plugins)
