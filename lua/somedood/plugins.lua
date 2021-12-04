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

    -- Language Server Protocol
    use {
        'neoclide/coc.nvim',
        branch = 'release',
        config = require'somedood.configs.coc',
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
        'fannheyward/telescope-coc.nvim',
        requires = 'nvim-telescope/telescope.nvim',
        config = telescope.coc,
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
