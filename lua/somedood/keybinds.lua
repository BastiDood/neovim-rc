local noremap = { noremap = true }
local silent_noremap = { noremap = true, silent = true }

-- Telescope Keybindings
local t = require'telescope.builtin'
vim.keymap.set('n', '<C-f>', t.current_buffer_fuzzy_find, silent_noremap )
vim.keymap.set('n', '<C-S-f>', t.live_grep, silent_noremap )
vim.keymap.set('n', '<C-,>', function() t.find_files({ cwd = vim.fn.stdpath('config') }) end, silent_noremap)
vim.keymap.set('n', '<leader>ff', t.find_files, silent_noremap)
vim.keymap.set('n', '<leader>ft', t.treesitter, silent_noremap)
vim.keymap.set('n', '<leader>fG', t.git_files, silent_noremap)
vim.keymap.set('n', '<leader>Gb', t.git_branches, silent_noremap)
vim.keymap.set('n', '<leader>fb', t.buffers, silent_noremap)

-- Vim Fugitive Keybindings
vim.keymap.set('n', '<leader>Gs', [[<cmd>Git<cr>]], silent_noremap)
vim.keymap.set('n', '<leader>Gc', [[<cmd>Git commit<cr>]], silent_noremap)
vim.keymap.set('n', '<leader>Gp', [[<cmd>Git push<cr>]], silent_noremap)

-- NvimTree Keybindings
vim.keymap.set('n', '<leader>n', [[<cmd>NvimTreeToggle<cr>]], noremap)

-- Neovim Keybindings
vim.keymap.set('n', '<C-s>', [[<cmd>up<cr>]], silent_noremap)
vim.keymap.set('n', '<C-S-k>', [[<cmd>m .-2<cr>==]], noremap)
vim.keymap.set('n', '<C-S-j>', [[<cmd>m .+1<cr>==]], noremap)
vim.keymap.set('x', '<leader>p', '"_dP', noremap)
vim.keymap.set('n', 'c[', require'treesitter-context'.go_to_context, silent_noremap)
