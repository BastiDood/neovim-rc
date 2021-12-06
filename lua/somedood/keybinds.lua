local api = vim.api

local noremap = { noremap = true }
local silent_noremap = { noremap = true, silent = true }

-- Telescope Keybindings
api.nvim_set_keymap('n', '<C-p>', [[<cmd>Telescope file_browser<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<C-f>', [[<cmd>Telescope current_buffer_fuzzy_find<cr>]], silent_noremap )
api.nvim_set_keymap('n', '<C-S-f>', [[<cmd>Telescope live_grep<cr>]], silent_noremap )
api.nvim_set_keymap('n', '<C-,>', [[<cmd>lua require'telescope.builtin'.find_files({ cwd = vim.fn.stdpath('config') })<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>ff', [[<cmd>Telescope find_files<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>ft', [[<cmd>Telescope treesitter<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>fG', [[<cmd>Telescope git_files<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>Gb', [[<cmd>Telescope git_branches<cr>]], silent_noremap)
api.nvim_set_keymap('n', '<leader>fb', [[<cmd>Telescope buffers<cr>]], silent_noremap)

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
