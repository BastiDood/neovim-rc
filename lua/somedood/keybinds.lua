local noremap = { noremap = true }

-- Font Resizing
local default = 10
local size = default

local function update_font()
    vim.opt.guifont = { 'JetBrains Mono:h' .. size, 'JetBrainsMono NF:h' .. size }
end

local function update_with_print()
    update_font()
    vim.print('Font size changed to ' .. size)
end

update_font()
vim.keymap.set('n', '<C-0>', function()
    -- Reset Font
    size = default
    update_with_print()
end, noremap)
vim.keymap.set('n', '<C-->', function()
    -- Decrement Font
    size = math.max(size - 1, 2)
    update_with_print()
end, noremap)
vim.keymap.set('n', '<C-=>', function()
    -- Increase Font
    size = size + 1
    update_with_print()
end, noremap)

-- Goneovim
local fullscreen = false
if vim.g.gonvim_running then
    vim.keymap.set('n', '<F11>', function()
        fullscreen = not fullscreen
        vim.cmd { cmd = 'GonvimFullscreen', args = { fullscreen and 1 or 0 } }
    end, noremap)
end

-- Open main menu for plugin managers.
vim.keymap.set('n', '<leader>l', function() require'lazy'.home() end, noremap)
vim.keymap.set('n', '<leader>m', function() vim.cmd 'Mason' end, noremap)

-- Disable search highlights on escape.
vim.keymap.set('n', '<Esc>', function() vim.cmd 'nohlsearch' end, noremap)

-- Convenient shortcuts for dealing with lines of text.
vim.keymap.set('n', '<C-s>', [[<cmd>up<cr>]], noremap)
vim.keymap.set('n', '<C-S-k>', [[<cmd>m .-2<cr>==]], noremap)
vim.keymap.set('n', '<C-S-j>', [[<cmd>m .+1<cr>==]], noremap)
vim.keymap.set('x', '<leader>p', '"_dP', noremap)

-- Convenience shortcuts for moving the focus from one window to another.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move Focus to the Left Window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move Focus to the Right Window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move Focus to the Lower Window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move Focus to the Upper Window' })
