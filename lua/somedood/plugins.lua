function plugins(use)
    -- Plugin Manager
    use 'wbthomason/packer.nvim'

    -- Editor Theming
    use 'sainnhe/edge'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = require'somedood.configs.lualine',
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
        config = require'somedood.configs.telescope'.core,
    }
    use {
        'nvim-telescope/telescope-fzy-native.nvim',
        requires = 'nvim-telescope/telescope.nvim',
        config = require'somedood.configs.telescope'.fzy,
    }
    use {
        'fannheyward/telescope-coc.nvim',
        requires = 'nvim-telescope/telescope.nvim',
        config = require'somedood.configs.telescope'.coc,
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

    -- Miscellaneous
    use 'tpope/vim-fugitive'
    use {
        'kyazdani42/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        config = require'somedood.configs.nvim-tree',
    }
end

return require'packer'.startup(plugins)
