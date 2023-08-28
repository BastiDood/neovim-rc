local noremap = { noremap = true }

-- Font Resizing
local default = 10
local size = default

local function update_font()
    vim.opt.guifont = 'JetBrains Mono:h' .. size
end

local function update_with_print()
    update_font()
    vim.print('Font size changed to ' .. size)
end

local function rst_font()
    size = default
    update_with_print()
end

local function inc_font()
    size = size + 1
    update_with_print()
end

local function dec_font()
    size = math.max(size - 1, 2)
    update_with_print()
end

update_font()
vim.keymap.set('n', '<C-0>', rst_font, noremap)
vim.keymap.set('n', '<C-->', dec_font, noremap)
vim.keymap.set('n', '<C-=>', inc_font, noremap)

-- Goneovim
local fullscreen = false
if vim.g.gonvim_running then
    vim.keymap.set('n', '<F11>', function()
        fullscreen = not fullscreen
        vim.cmd { cmd = 'GonvimFullscreen', args = { fullscreen and 1 or 0 } }
    end, noremap)
end

-- Lazy.nvim
vim.keymap.set('n', '<leader>l', function() require'lazy'.home() end, noremap)

-- Neovim
vim.keymap.set('n', '<C-s>', [[<cmd>up<cr>]], noremap)
vim.keymap.set('n', '<C-S-k>', [[<cmd>m .-2<cr>==]], noremap)
vim.keymap.set('n', '<C-S-j>', [[<cmd>m .+1<cr>==]], noremap)
vim.keymap.set('x', '<leader>p', '"_dP', noremap)
