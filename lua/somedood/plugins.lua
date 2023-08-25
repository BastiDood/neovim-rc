-- Initialize Lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--depth=1',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Define plugins.
local telescope = require'somedood.configs.telescope'
require'lazy'.setup({
    { 'sainnhe/edge', config = require'somedood.configs.edge', lazy = false },
    { 'rust-lang/rust.vim', ft = 'rust' },
    'rafamadriz/friendly-snippets',
    'L3MON4D3/LuaSnip',
    {
        'hrsh7th/nvim-cmp',
        dependencies = { 'L3MON4D3/LuaSnip' },
        config = require'somedood.configs.cmp',
    },
    { 'hrsh7th/cmp-buffer', dependencies = { 'hrsh7th/nvim-cmp' } },
    { 'saadparwaiz1/cmp_luasnip', dependencies = { 'hrsh7th/nvim-cmp' } },
    { 'hrsh7th/cmp-nvim-lsp', dependencies = { 'hrsh7th/nvim-cmp' } },
    { 'hrsh7th/cmp-path', dependencies = { 'hrsh7th/nvim-cmp' } },
    {
        'windwp/nvim-autopairs',
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = require'somedood.configs.autopairs',
    },
    'b0o/schemastore.nvim',
    'nvim-lua/lsp_extensions.nvim',
    { 'nvim-lua/lsp-status.nvim', config = require'somedood.configs.lsp-status' },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'b0o/schemastore.nvim',
            'nvim-lua/lsp_extensions.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'nvim-lua/lsp-status.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = require'somedood.configs.lsp',
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-lua/lsp-status.nvim' },
        config = require'somedood.configs.lualine',
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
        config = telescope.core,
    },
    {
        'nvim-telescope/telescope-fzy-native.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        config = telescope.fzy,
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        config = telescope.ui,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = require'somedood.configs.treesitter',
    },
    {
        'numToStr/Comment.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = require'somedood.configs.comment',
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = require'somedood.configs.context',
    },
    'tpope/vim-fugitive',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    {
        'nvim-tree/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        config = require'somedood.configs.nvim-tree',
    },
}, {
    ui = {
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'tarPlugin',
                'zipPlugin',
                'tohtml',
                'tutor',
                'netrwPlugin',
                'shada',
                'spellfile',
            },
        },
    },
})
