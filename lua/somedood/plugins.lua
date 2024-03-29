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
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'b0o/schemastore.nvim',
            'nvim-lua/lsp_extensions.nvim',
        },
        config = require'somedood.configs.lsp',
    },
    {
        'nvim-lualine/lualine.nvim',
        config = require'somedood.configs.lualine',
    },
    {
        -- FIXME: Regularly check for progress on the rewrite!
        'j-hui/fidget.nvim',
        tag = 'legacy',
        event = 'LspAttach',
        config = require'somedood.configs.fidget',
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -GNinja -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
                config = telescope.fzf,
            },
            { 'nvim-telescope/telescope-ui-select.nvim', config = telescope.ui },
        },
        keys = {
            { '<C-f>' , function() require'telescope.builtin'.current_buffer_fuzzy_find() end },
            { '<C-S-f>' , function() require'telescope.builtin'.live_grep() end },
            { '<C-,>' , function() require'telescope.builtin'.find_files({ cwd = vim.fn.stdpath('config') }) end },
            { '<leader>ff' , function() require'telescope.builtin'.find_files() end },
            { '<leader>ft' , function() require'telescope.builtin'.treesitter() end },
            { '<leader>fG' , function() require'telescope.builtin'.git_files() end },
            { '<leader>Gb' , function() require'telescope.builtin'.git_branches() end },
            { '<leader>fb' , function() require'telescope.builtin'.buffers() end },
        },
        config = telescope.core,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-context', config = require'somedood.configs.context' },
            { 'nushell/tree-sitter-nu' },
        },
        keys = { { 'c[', function() require'treesitter-context'.go_to_context() end } },
        config = require'somedood.configs.treesitter',
    },
    {
        'numToStr/Comment.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = require'somedood.configs.comment',
    },
    { 'tpope/vim-fugitive', keys = { { '<leader>Gs', [[<cmd>Git<cr>]] } } },
    { 'tpope/vim-repeat', event = { 'BufReadPre', 'BufNewFile' } },
    { 'tpope/vim-surround', event = 'InsertEnter' },
    {
        'nvim-tree/nvim-tree.lua',
        keys = { { '<leader>n', function() require'nvim-tree.api'.tree.toggle() end } },
        config = require'somedood.configs.nvim-tree',
    },
}, {
    install = { colorscheme = { 'edge' } },
    change_detection = { enabled = false },
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
