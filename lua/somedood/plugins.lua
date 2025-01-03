-- Initialize Lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    local out = vim.fn.system {
        'git',
        'clone',
        '--depth=1',
        '--filter=blob:none',
        '--branch=stable',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Define plugins.
require'lazy'.setup {
    defaults = { lazy = true },
    spec = {
        { 'echasnovski/mini.icons', version = false, opts = { style = 'ascii' } },
        {
            'sainnhe/edge',
            lazy = false,
            priority = 1000,
            config = require'somedood.configs.edge'
        },
        {
            'echasnovski/mini.statusline',
            lazy = false,
            version = false,
            opts = { use_icons = false, set_vim_settings = false },
        },
        {
            'lukas-reineke/indent-blankline.nvim',
            event = { 'BufReadPost', 'BufNewFile' },
            main = 'ibl', opts = { },
        },
        { 'echasnovski/mini.ai', version = false, event = 'InsertEnter', opts = { } },
        { 'kylechui/nvim-surround', version = '*', event = 'InsertEnter', opts = { } },
        { 'tpope/vim-sleuth', event = { 'BufReadPost', 'BufNewFile' } },
        { 'tpope/vim-fugitive', keys = { { '<leader>Gs', function() vim.cmd 'Git' end } } },
        { 'L3MON4D3/LuaSnip', dependencies = { 'rafamadriz/friendly-snippets' } },
        {
            'rafamadriz/friendly-snippets',
            config = function() require'luasnip.loaders.from_vscode'.lazy_load() end,
        },
        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            dependencies = {
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-path',
            },
            config = require'somedood.configs.cmp',
        },
        {
            'windwp/nvim-autopairs',
            event = 'InsertEnter',
            opts = { check_ts = true },
        },
        {
            'williamboman/mason.nvim',
            opts = { },
            keys = { { '<leader>m', function() vim.cmd 'Mason' end } },
        },
        { 'j-hui/fidget.nvim', opts = { } },
        {
            'neovim/nvim-lspconfig',
            event = { 'BufReadPost', 'BufNewFile' },
            cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
            dependencies = {
                'williamboman/mason.nvim',
                'williamboman/mason-lspconfig.nvim',
                'WhoIsSethDaniel/mason-tool-installer.nvim',
                'hrsh7th/cmp-nvim-lsp',
                'b0o/schemastore.nvim',
                'j-hui/fidget.nvim',
            },
            config = require'somedood.configs.lsp',
        },
        {
            'pmizio/typescript-tools.nvim',
            dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
            opts = { },
        },
        {
            'echasnovski/mini.files',
            version = false,
	    keys = { { '<leader>n', function() require'mini.files'.open() end } },
            dependencies = { 'echasnovski/mini.icons' },
            opts = { },
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -GNinja -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
            config = function() require'telescope'.load_extension'fzf' end,
        },
        {
            'nvim-telescope/telescope-ui-select.nvim',
            config = function() require'telescope'.load_extension'ui-select' end,
        },
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/popup.nvim',
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-fzf-native.nvim',
                'nvim-telescope/telescope-ui-select.nvim',
            },
            keys = {
                { '<C-f>', function() require'telescope.builtin'.current_buffer_fuzzy_find() end },
                { '<C-S-f>', function() require'telescope.builtin'.live_grep() end },
                { '<C-,>', function() require'telescope.builtin'.find_files { cwd = vim.fn.stdpath 'config' } end },
                { '<leader>ff', function() require'telescope.builtin'.find_files() end },
                { '<leader>ft', function() require'telescope.builtin'.treesitter() end },
                { '<leader>fG', function() require'telescope.builtin'.git_files() end },
                { '<leader>Gb', function() require'telescope.builtin'.git_branches() end },
                { '<leader>fb', function() require'telescope.builtin'.buffers() end },
            },
            config = require'somedood.configs.telescope',
        },
        { 'nvim-treesitter/nvim-treesitter-context', opts = { } },
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            dependencies = { 'nvim-treesitter/nvim-treesitter-context' },
            cmd = { 'TSUpdate', 'TSInstall', 'TSUninstall' },
            event = { 'BufReadPost', 'BufNewFile' },
            keys = { { 'c[', function() require'treesitter-context'.go_to_context() end } },
            opts = {
                ensure_installed = {
                    'bash',
                    'c',
                    'comment',
                    'cpp',
                    'css',
                    'dockerfile',
                    'git_rebase',
                    'gitcommit',
                    'gitignore',
                    'html',
                    'javascript',
                    'jsdoc',
                    'jsonc',
                    'lua',
                    'markdown',
                    'nu',
                    'python',
                    'rust',
                    'sql',
                    'svelte',
                    'toml',
                    'tsx',
                    'typescript',
                    'vim',
                    'yaml',
                    'zig',
                },
                indent = { enable = true },
                highlight = { enable = true, additional_vim_regex_highlighting = false },
            },
            config = function(_, opts)
                -- Prefer Git instead of cURL in order to improve connectivity in some environments.
                require'nvim-treesitter.install'.prefer_git = true
                require'nvim-treesitter.configs'.setup(opts)
            end,
        },
    },
    install = { colorscheme = { 'edge' } },
    change_detection = { enabled = false },
    ui = {
        icons = {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            favorite = '❤',
            ft = '📂',
            init = '⚙',
            import = '📦',
            keys = '🗝',
            lazy = '💤',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            list = { '=>>', '==>', '->>', '-->', '~~>' },
        },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'editorconfig',
                'gzip',
                'tarPlugin',
                'zipPlugin',
                'tohtml',
                'tutor',
                'netrwPlugin',
                'shada',
                'spellfile',
                'rplugin',
            },
        },
    },
}
