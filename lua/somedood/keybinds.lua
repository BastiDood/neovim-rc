local api = vim.api

local noremap = { noremap = true }
local silent = { silent = true }
local silent_expr = { silent = true, expr = true }
local silent_noremap = { noremap = true, silent = true }
local silent_noremap_expr = { noremap = true, expr = true, silent = true }
local silent_noremap_expr_nowait = { noremap = true, expr = true, silent = true, nowait = true }

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
api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', silent_expr)
api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', silent)
api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', silent)
api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', silent)
api.nvim_set_keymap('n', '<f2>', '<Plug>(coc-rename)', silent)
api.nvim_set_keymap('n', 'K', [[<cmd>lua show_documentation()<cr>]], silent_noremap)
api.nvim_set_keymap('v', 'K', [[<cmd>lua show_documentation()<cr>]], silent_noremap)

-- CoC Floating Windows
local down_key = '<C-Down>'
local up_key = '<C-Up>'
function scroll_floating_window(down)
    if vim.fn['coc#float#has_scroll']() then
        return vim.fn['coc#float#scroll'](down)
    else
        local key = down and down_key or up_key
        return vim.api.nvim_replace_termcodes(key)
    end
end
api.nvim_set_keymap('n', down_key, 'v:lua.scroll_floating_window(1)', silent_noremap_expr_nowait)
api.nvim_set_keymap('n', up_key, 'v:lua.scroll_floating_window(0)', silent_noremap_expr_nowait)

-- Telescope Keybindings
api.nvim_set_keymap('n', '<C-p>', [[<cmd>Telescope file_browser<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<C-f>', [[<cmd>Telescope current_buffer_fuzzy_find<cr>]], silent_noremap )
api.nvim_set_keymap('n', '<C-,>', [[<cmd>lua require'telescope.builtin'.find_files({ cwd = vim.fn.stdpath('config') })<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>ff', [[<cmd>Telescope fd<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>ft', [[<cmd>Telescope treesitter<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>fG', [[<cmd>Telescope git_files<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>Gb', [[<cmd>Telescope git_branches<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>fb', [[<cmd>Telescope buffers<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>cc', [[<cmd>Telescope coc commands<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>ca', [[<cmd>Telescope coc code_actions<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>ds', [[<cmd>Telescope coc document_symbols<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>ws', [[<cmd>Telescope coc workspace_symbols<cr>]], silent_noremap)

-- Vim Fugitive Keybindings
api.nvim_set_keymap('n', '<leader>Gs', [[<cmd>Git<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>Ga', [[<cmd>Git add .<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>Gc', [[<cmd>Git commit<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>Gp', [[<cmd>Git push<cr>]], silent_noremap)

-- NvimTree Keybindings
api.nvim_set_keymap('n', '<C-e>', [[<cmd>NvimTreeToggle<cr>]], noremap)

-- Neovim Keybindings
api.nvim_set_keymap('n', '<C-s>', [[<cmd>up<cr>]], silent_noremap)
api.nvim_set_keymap('n', 'Y', 'y$', noremap)
api.nvim_set_keymap('n', '<C-S-k>', [[<cmd>m .-2<cr>==]], noremap)
api.nvim_set_keymap('n', '<C-S-j>', [[<cmd>m .+1<cr>==]], noremap)
