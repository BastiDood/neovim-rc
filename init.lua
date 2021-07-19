local silent = { silent = true }
local silent_expr = { silent = true, expr = true }
local silent_noremap = { noremap = true, silent = true }
local silent_noremap_expr = { noremap = true, expr = true, silent = true }
local silent_noremap_expr_nowait = { noremap = true, expr = true, silent = true, nowait = true }

-- Initialize plugins
require'plugins'

-- Switch to development directory
vim.cmd('cd /Dev')

-- Map leader key
vim.g.mapleader = ' '

-- Indentation
vim.o.foldmethod = 'expr'
vim.o.foldexpr = [[nvim_treesitter#foldexpr()]]
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.smarttab = true

-- Performance Options
vim.o.lazyredraw = true

-- Text Rendering Options
vim.o.termguicolors = true
vim.o.encoding = 'UTF-8'
vim.o.wrap = true
vim.o.linebreak = true
vim.o.scrolloff = 5
vim.o.hlsearch = false

-- User Interface Options
vim.o.mouse = 'n'
vim.o.showmode = false
vim.o.ruler = true
vim.o.tabpagemax = 5
vim.o.cursorline = true
vim.o.signcolumn = 'yes'
vim.o.number = true
vim.o.relativenumber = true
vim.o.nu = true
vim.o.rnu = true
vim.o.splitbelow = true
vim.o.splitright = true

-- Miscellaneous
vim.opt.shortmess:append({ c = true })
vim.opt.clipboard:append({ 'unnamedplus' })
vim.o.hidden = true
vim.o.history = 500
vim.o.backup = false
vim.o.writebackup = false

-- Vim Markdown
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_math = 1
vim.g.vim_markdown_strikethrough = 1
vim.g.vim_markdown_auto_insert_bullets = 1
vim.g.vim_markdown_no_default_key_mappings = 1
vim.g.vim_markdown_folding_disabled = 1

-- Netrw Options
vim.g.netrw_liststyle = 3

-- Edge Colorschema Settings
vim.g.edge_better_performance = 1
vim.g.edge_enable_italic = 0
vim.g.edge_disable_italic_comment = 1
vim.g.edge_diagnostic_virtual_text = 'colored'
vim.cmd('colorscheme edge')

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
vim.g.coc_global_extensions = {
    'coc-clangd',
    'coc-cmake',
    'coc-deno',
    'coc-emmet',
    'coc-json',
    'coc-pairs',
    'coc-pyright',
    'coc-rust-analyzer',
    'coc-tsserver',
}

-- Coc Documentation
function show_documentation()
    local filetype = vim.bo.filetype
    if filetype == 'vim' or filetype == 'help' then
        local cword = vim.fn.expand('<cword>')
        vim.api.nvim_command('help ' .. cword)
    elseif vim.fn['coc#rpc#ready']() then
        vim.fn.CocActionAsync('doHover')
    else
        local keyword = vim.o.keywordprg
        local cword = vim.fn.expand('<cword>')
        local command = string.format('%s %s', keyword, cword)
        vim.cmd(command)
    end
end

-- CoC Keybindings
vim.api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', silent_expr)
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', silent)
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', silent)
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', silent)
vim.api.nvim_set_keymap('n', '<f2>', '<Plug>(coc-rename)', silent)
vim.api.nvim_set_keymap('n', 'K', [[<cmd>lua show_documentation()<cr>]], silent_noremap)

-- CoC Floating Windows
vim.api.nvim_set_keymap('n', '<C-Down>', [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]], silent_noremap_expr_nowait)
vim.api.nvim_set_keymap('n', '<C-Up>', [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]], silent_noremap_expr_nowait)
vim.api.nvim_set_keymap('i', '<C-Down>', [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"]], silent_noremap_expr_nowait)
vim.api.nvim_set_keymap('i', '<C-Up>', [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"]], silent_noremap_expr_nowait)
vim.api.nvim_set_keymap('v', '<C-Down>', [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]], silent_noremap_expr_nowait)
vim.api.nvim_set_keymap('v', '<C-Up>', [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]], silent_noremap_expr_nowait)

-- Telescope Configuration
require'telescope'.setup {
    defaults = {
        file_sorter = require'telescope.sorters'.get_fzy_sorter,
        mappings = {
            i = { [ '<esc>' ] = require'telescope.actions'.close },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    },
}
require'telescope'.load_extension('fzy_native')
require'telescope'.load_extension('coc')

-- Telescope Keybindings
vim.api.nvim_set_keymap('n', '<C-e>', [[<cmd>Telescope file_browser<cr>]], silent_noremap)
vim.api.nvim_set_keymap('n', '<C-f>', [[<cmd>Telescope current_buffer_fuzzy_find<cr>]], silent_noremap )
vim.api.nvim_set_keymap('n', '<C-,>', [[<cmd>lua require'telescope.builtin'.find_files({ cwd = vim.fn.stdpath('config') })<cr>]], silent_noremap)
vim.api.nvim_set_keymap('n', 'ff', [[<cmd>Telescope fd<cr>]], silent_noremap)
vim.api.nvim_set_keymap('n', 'ft', [[<cmd>Telescope treesitter<cr>]], silent_noremap)
vim.api.nvim_set_keymap('n', 'fG', [[<cmd>Telescope git_files<cr>]], silent_noremap)
vim.api.nvim_set_keymap('n', 'Gb', [[<cmd>Telescope git_branches<cr>]], silent_noremap)
vim.api.nvim_set_keymap('n', 'fb', [[<cmd>Telescope buffers<cr>]], silent_noremap)
vim.api.nvim_set_keymap('n', 'cc', [[<cmd>Telescope coc commands<cr>]], silent_noremap)
vim.api.nvim_set_keymap('n', 'ca', [[<cmd>Telescope coc code_actions<cr>]], silent_noremap)
vim.api.nvim_set_keymap('n', 'ds', [[<cmd>Telescope coc document_symbols<cr>]], silent_noremap)
vim.api.nvim_set_keymap('n', 'ws', [[<cmd>Telescope coc workspace_symbols<cr>]], silent_noremap)

-- Treesitter Configuration
require'nvim-treesitter.configs'.setup {
    indent = { enable = true },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Vim Fugitive Shortcuts
vim.api.nvim_set_keymap('n', '<leader>Gs', [[<cmd>Git<cr>]], silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>Ga', [[<cmd>Git add .<cr>]], silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>Gc', [[<cmd>Git commit<cr>]], silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>Gp', [[<cmd>Git push<cr>]], silent_noremap)

-- Custom Keybindings
vim.api.nvim_set_keymap('n', '<C-s>', [[<cmd>w<cr>]], silent_noremap)
