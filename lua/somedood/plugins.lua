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
    spec = {
        'tpope/vim-sleuth',
        { 'sainnhe/edge', config = require'somedood.configs.edge' },
        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            dependencies = {
                {
                    'L3MON4D3/LuaSnip',
                    dependencies = {
                        {
                            'rafamadriz/friendly-snippets',
                            config = function() require'luasnip.loaders.from_vscode'.lazy_load() end,
                        },
                    },
                },
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
            config = require'somedood.configs.autopairs',
        },
        {
            'neovim/nvim-lspconfig',
            event = { 'BufReadPre', 'BufNewFile' },
            dependencies = {
                'b0o/schemastore.nvim',
                'nvim-lua/lsp_extensions.nvim',
                { 'j-hui/fidget.nvim', opts = { } },
            },
            config = require'somedood.configs.lsp',
        },
        {
            'nvim-lualine/lualine.nvim',
            opts = {
                extensions = { 'nvim-tree', 'fugitive' },
                options = { theme = 'edge', icons_enabled = false },
            },
        },
        {
            'nvim-telescope/telescope.nvim',
            event = 'VimEnter',
            dependencies = {
                'nvim-lua/popup.nvim',
                'nvim-lua/plenary.nvim',
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    build = 'cmake -S. -GNinja -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
                    config = function() require'telescope'.load_extension'fzf' end,
                },
                {
                    'nvim-telescope/telescope-ui-select.nvim',
                    config = function() require'telescope'.load_extension'ui-select' end,
                },
            },
            keys = {
                { '<C-f>' , function() require'telescope.builtin'.current_buffer_fuzzy_find() end },
                { '<C-S-f>' , function() require'telescope.builtin'.live_grep() end },
                { '<C-,>' , function() require'telescope.builtin'.find_files { cwd = vim.fn.stdpath 'config' } end },
                { '<leader>ff' , function() require'telescope.builtin'.find_files() end },
                { '<leader>ft' , function() require'telescope.builtin'.treesitter() end },
                { '<leader>fG' , function() require'telescope.builtin'.git_files() end },
                { '<leader>Gb' , function() require'telescope.builtin'.git_branches() end },
                { '<leader>fb' , function() require'telescope.builtin'.buffers() end },
            },
            config = require'somedood.configs.telescope',
        },
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            dependencies = {
                { 'nvim-treesitter/nvim-treesitter-context', opts = { } },
                'nushell/tree-sitter-nu',
            },
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
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            },
            config = function(_, opts)
                -- Prefer Git instead of cURL in order to improve connectivity in some environments.
                require'nvim-treesitter.install'.prefer_git = true
                require'nvim-treesitter.configs'.setup(opts)
            end,
        },
        {
            'numToStr/Comment.nvim',
            event = { 'BufReadPre', 'BufNewFile' },
            opts = { mappings = { extra = false } },
        },
        { 'tpope/vim-fugitive', keys = { { '<leader>Gs', [[<cmd>Git<cr>]] } } },
        { 'tpope/vim-repeat', event = { 'BufReadPre', 'BufNewFile' } },
        { 'tpope/vim-surround', event = 'InsertEnter' },
        {
            'nvim-tree/nvim-tree.lua',
            keys = { { '<leader>n', function() require'nvim-tree.api'.tree.toggle() end } },
            opts = {
                auto_reload_on_write = false,
                update_cwd = true,
                hijack_cursor = true,
                filters = { dotfiles = true },
                renderer = {
                    add_trailing = true,
                    group_empty = true,
                    indent_markers = { enable = true },
                    icons = {
                        show = {
                            file = false,
                            folder = false,
                            folder_arrow = false,
                            git = false,
                            modified = false,
                        },
                    },
                },
                git = { ignore = true },
                view = { side = 'right' },
            }
        },
    },
    install = { colorscheme = { 'edge' } },
    change_detection = { enabled = false },
    ui = {
	icons = {
	    cmd = '⌘',
	    config = '🛠',
	    event = '📅',
	    ft = '📂',
	    init = '⚙',
	    keys = '🗝',
	    plugin = '🔌',
	    runtime = '💻',
	    require = '🌙',
	    source = '📄',
	    start = '🚀',
	    task = '📌',
	    lazy = '💤 ',
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
}
