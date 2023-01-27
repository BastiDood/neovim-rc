function plugins(use)
    -- Plugin Manager
    use 'wbthomason/packer.nvim'

    -- Editor Theming
    use {
        'sainnhe/edge',
        config = require'somedood.configs.edge',
    }

    -- Language Support
    use { 'rust-lang/rust.vim', ft = 'rust' }
    use 'harenome/vim-mipssyntax'

    -- Snippet Engine
    use 'rafamadriz/friendly-snippets'
    use 'L3MON4D3/LuaSnip'
    use {
        'hrsh7th/nvim-cmp',
        requires = 'L3MON4D3/LuaSnip',
        config = require'somedood.configs.cmp',
    }
    use {
        'hrsh7th/cmp-buffer',
        requires = 'hrsh7th/nvim-cmp',
    }
    use {
        'saadparwaiz1/cmp_luasnip',
        requires = 'hrsh7th/nvim-cmp',
    }
    use {
        'hrsh7th/cmp-nvim-lsp',
        requires = 'hrsh7th/nvim-cmp',
    }
    use {
        'hrsh7th/cmp-path',
        requires = 'hrsh7th/nvim-cmp',
    }
    use {
        'windwp/nvim-autopairs',
        requires = 'hrsh7th/nvim-cmp',
        config = require'somedood.configs.autopairs',
    }

    -- Language Server
    use 'b0o/schemastore.nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    use {
        'nvim-lua/lsp-status.nvim',
        config = require'somedood.configs.lsp-status',
    }
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'b0o/schemastore.nvim',
            'nvim-lua/lsp_extensions.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'nvim-lua/lsp-status.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = require'somedood.configs.lsp',
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'nvim-lua/lsp-status.nvim',
            { 'nvim-tree/nvim-web-devicons', opt = true },
        },
        config = require'somedood.configs.lualine',
    }

    -- Telescope
    local telescope = require'somedood.configs.telescope'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
        config = telescope.core,
    }
    use {
        'nvim-telescope/telescope-fzy-native.nvim',
        requires = 'nvim-telescope/telescope.nvim',
        config = telescope.fzy,
    }
    use {
        'nvim-telescope/telescope-ui-select.nvim',
        requires = 'nvim-telescope/telescope.nvim',
        config = telescope.ui,
    }

    -- Syntax Analyzer
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = require'somedood.configs.treesitter',
    }
    use {
        'numToStr/Comment.nvim',
        requires = 'nvim-treesitter/nvim-treesitter',
        config = require'somedood.configs.comment',
    }

    -- Miscellaneous
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use {
        'nvim-tree/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        config = require'somedood.configs.nvim-tree',
    }
end

return require'packer'.startup(plugins)
