local noremap = { noremap = true }
local silent_noremap = { noremap = true, silent = true }

-- Lazy.nvim
vim.keymap.set('n', '<leader>l', function() require'lazy'.home() end, silent_noremap)

-- Vim Fugitive
vim.keymap.set('n', '<leader>Gs', [[<cmd>Git<cr>]], silent_noremap)

-- Neovim
vim.keymap.set('n', '<C-s>', [[<cmd>up<cr>]], silent_noremap)
vim.keymap.set('n', '<C-S-k>', [[<cmd>m .-2<cr>==]], noremap)
vim.keymap.set('n', '<C-S-j>', [[<cmd>m .+1<cr>==]], noremap)
vim.keymap.set('x', '<leader>p', '"_dP', noremap)
vim.keymap.set('n', 'c[', require'treesitter-context'.go_to_context, silent_noremap)
