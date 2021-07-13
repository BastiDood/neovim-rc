cd /Dev

let g:mapleader = ' '

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" Customize Behavior for Lightline
let g:lightline = {
      \ 'colorscheme': 'edge',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'gitbranch', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" Plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'itchyny/lightline.vim'
Plug 'rust-lang/rust.vim'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'plasticboy/vim-markdown'
Plug 'mattn/emmet-vim'
Plug 'sainnhe/edge'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call plug#end()

" Indentation Options
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

" Search Options
set nohlsearch
set ignorecase
set incsearch
set smartcase

" Performance Options
set lazyredraw

" Text Rendering Options
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_auto_insert_bullets = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_folding_disabled = 1
let g:edge_better_performance = 1
let g:edge_enable_italic = 0
let g:edge_disable_italic_comment = 1
let g:edge_diagnostic_virtual_text = 'colored'
syntax enable
set termguicolors
colorscheme edge
set encoding=UTF-8
set wrap
set linebreak
set scrolloff=5
set ff=dos
filetype plugin indent on

" User Interface Options
set mouse=n
set noshowmode
set ruler
set tabpagemax=5
set cursorline
set signcolumn=yes
set number relativenumber
set nu rnu

" Miscellaneous Options
set shortmess+=c
set clipboard^=unnamed,unnamedplus
set hidden
set history=500
set nobackup
set nowritebackup

" Keyboard Remapping
nnoremap <C-s> <cmd>w<CR>

" CoC Commands
let g:coc_global_extensions = [
    \'coc-clangd',
    \'coc-cmake',
    \'coc-deno',
    \'coc-emmet',
    \'coc-json',
    \'coc-pairs',
    \'coc-pyright',
    \'coc-rust-analyzer',
    \'coc-tsserver',
\]
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <f2> <Plug>(coc-rename)
nnoremap <silent> K <cmd>call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Telescope Configuration
lua <<EOF
require'telescope'.setup {
    defaults = {
        file_sorter = require'telescope.sorters'.get_fzy_sorter,
        mappings = { i = { [ '<esc>' ] = require'telescope.actions'.close } },
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
EOF

" Telescope-related Keyboard Mappings
nnoremap <C-e> <cmd>Telescope file_browser<cr>
nnoremap <C-f> <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <C-,> <cmd>lua require'telescope.builtin'.find_files({ cwd = vim.fn.stdpath('config') })<CR>
nnoremap <leader>ff <cmd>Telescope fd<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>
nnoremap <leader>fG <cmd>Telescope git_files<cr>
nnoremap <leader>Gb <cmd>Telescope git_branches<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>cc <cmd>Telescope coc commands<cr>
nnoremap <leader>ca <cmd>Telescope coc code_actions<cr>
nnoremap <leader>cd <cmd>Telescope coc diagnostics<cr>
nnoremap <leader>dc <cmd>Telescope coc document_symbols<cr>
nnoremap <leader>ws <cmd>Telescope coc workspace_symbols<cr>
nnoremap <leader>wd <cmd>Telescope coc workspace_diagnostics<cr>

" Treesitter Configuration
lua <<EOF
require'nvim-treesitter.configs'.setup {
    indent = { enable = true },
    highlight = { enable = true },
}
EOF

" Vim Fugitive Shortcuts
nnoremap <leader>Gs <cmd>Git<cr>
nnoremap <leader>Ga <cmd>Git add .<cr>
nnoremap <leader>Gc <cmd>Git commit<cr>
nnoremap <leader>Gp <cmd>Git push<cr>
