local g = vim.g

-- Leader Key
g.mapleader = ' '

-- Edge Colorscheme Settings
g.edge_enable_italic = 0
g.edge_disable_italic_comment = 1
g.edge_diagnostic_virtual_text = 'colored'

-- Lightline Configuration
vim.g.lightline = {
    colorscheme = 'edge',
    active = {
        left = {
            { 'mode', 'paste' },
            { 'branch', 'filename', 'modified', 'cocstatus' },
        },
    },
    component_function = {
        cocstatus = 'coc#status',
        branch = 'fugitive#head',
    },
}

-- CoC Configuration
g.coc_global_extensions = {
    'coc-clangd',
    'coc-cmake',
    'coc-prettier',
    'coc-css',
    'coc-deno',
    'coc-json',
    'coc-pairs',
    'coc-powershell',
    'coc-pyright',
    'coc-rust-analyzer',
    'coc-tsserver',
}

-- Treesitter Configuration
require'nvim-treesitter.configs'.setup {
    indent = { enable = true },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}


-- Telescope Configuration
local telescope = require'telescope'
local sorters = require'telescope.sorters'
local actions = require'telescope.actions'
telescope.setup {
    defaults = {
        file_sorter = sorters.get_fzy_sorter,
        mappings = {
            i = { [ '<esc>' ] = actions.close },
        },
    },
    pickers = { file_browser = { disable_devicons = true } },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    },
}

-- Telescope Extensions
telescope.load_extension('fzy_native')
telescope.load_extension('coc')

-- Vim Markdown
g.vim_markdown_frontmatter = 1
g.vim_markdown_math = 1
g.vim_markdown_strikethrough = 1
g.vim_markdown_auto_insert_bullets = 1
g.vim_markdown_no_default_key_mappings = 1
g.vim_markdown_folding_disabled = 1

-- NvimTree Configuration
g.nvim_tree_side = 'right'
g.nvim_tree_ignore = { '.vim', '.git', '.github', '.vscode', 'node_modules', 'target', 'build' }
g.nvim_tree_gitignore = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_add_trailing = 1
g.nvim_tree_group_empty = 1
g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1,
    folder_arrows = 1,
}

-- Netrw Options
g.netrw_liststyle = 3
