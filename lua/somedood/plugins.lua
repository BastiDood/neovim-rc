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
    { 'sainnhe/edge', config = require'somedood.configs.edge' },
    { 'rust-lang/rust.vim', ft = 'rust' },
    { 'rafamadriz/friendly-snippets', event = 'InsertEnter' },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
        config = require'somedood.configs.cmp',
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = require'somedood.configs.autopairs',
    },
    { 'nvim-lua/lsp-status.nvim', config = require'somedood.configs.lsp-status' },
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'b0o/schemastore.nvim', 'nvim-lua/lsp_extensions.nvim' },
        config = require'somedood.configs.lsp',
    },
    { 'nvim-lualine/lualine.nvim', config = require'somedood.configs.lualine' },
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
        event = { 'BufReadPre', 'BufNewFile' },
        config = require'somedood.configs.comment',
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = require'somedood.configs.context',
    },
    { 'tpope/vim-fugitive', cmd = 'Git' },
    'tpope/vim-repeat',
    { 'tpope/vim-surround', event = 'InsertEnter' },
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
