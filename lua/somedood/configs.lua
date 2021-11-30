local g = vim.g

-- Leader Key
g.mapleader = ' '

-- Edge Colorscheme Settings
g.edge_enable_italic = 0
g.edge_disable_italic_comment = 1
g.edge_diagnostic_virtual_text = 'colored'

-- CoC Configuration
g.coc_global_extensions = {
    'coc-clangd',
    'coc-cmake',
    'coc-css',
    'coc-deno',
    'coc-json',
    'coc-pairs',
    'coc-powershell',
    'coc-pyright',
    'coc-rust-analyzer',
    'coc-tsserver',
}

-- Vim Markdown
g.vim_markdown_frontmatter = 1
g.vim_markdown_math = 1
g.vim_markdown_strikethrough = 1
g.vim_markdown_auto_insert_bullets = 1
g.vim_markdown_no_default_key_mappings = 1
g.vim_markdown_folding_disabled = 1

-- Nvim-Tree Configuration
g.nvim_tree_indent_markers = 1
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
