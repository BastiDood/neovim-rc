function plugins(use)
    -- Plugin Manager
    use 'wbthomason/packer.nvim'

    -- Editor Theming
    use 'itchyny/lightline.vim'
    use 'sainnhe/edge'

    -- Language Support
    use { 'rust-lang/rust.vim', ft = 'rust' }
    use { 'jackguo380/vim-lsp-cxx-highlight', ft = { 'c', 'cpp' } }
    use { 'plasticboy/vim-markdown', ft = 'markdown' }

    -- Language Server Protocol
    use { 'neoclide/coc.nvim', branch = 'release' }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
    }
    use {
        'nvim-telescope/telescope-fzy-native.nvim',
        requires = 'nvim-telescope/telescope.nvim',
    }
    use {
        'fannheyward/telescope-coc.nvim',
        requires = 'nvim-telescope/telescope.nvim',
    }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- Miscellaneous
    use { 'kyazdani42/nvim-tree.lua', cmd = 'NvimTreeToggle' }
    use 'tpope/vim-fugitive'
end

return require'packer'.startup(plugins)
