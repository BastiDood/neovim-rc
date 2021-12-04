function plugins(use)
    -- Plugin Manager
    use 'wbthomason/packer.nvim'

    -- Editor Theming
    use {
        'sainnhe/edge',
        config = require'somedood.configs.edge',
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = require'somedood.configs.lualine',
    }

    -- Language Support
    use { 'rust-lang/rust.vim', ft = 'rust' }
    use {
        'plasticboy/vim-markdown',
        ft = 'markdown',
        config = require'somedood.configs.markdown',
    }

    -- Snippet Engine
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
    use {
        'neovim/nvim-lspconfig',
        requires = 'hrsh7th/cmp-nvim-lsp',
        config = require'somedood.configs.lsp',
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

    -- Syntax Analyzer
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = require'somedood.configs.treesitter',
    }
    use {
        'lukas-reineke/indent-blankline.nvim',
        requires = { 'nvim-treesitter/nvim-treesitter', 'sainnhe/edge' },
        config = require'somedood.configs.indent-blankline',
    }
    use {
        'numToStr/Comment.nvim',
        requires = 'nvim-treesitter/nvim-treesitter',
        config = require'somedood.configs.comment',
    }

    -- Miscellaneous
    use 'tpope/vim-fugitive'
    use {
        'kyazdani42/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        config = require'somedood.configs.nvim-tree',
    }
end

return require'packer'.startup(plugins)
