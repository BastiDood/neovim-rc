return function()
    local files = require'mini.files'
    vim.keymap.set('n', '<leader>n', files.open, { desc = 'Ope[n] mini.files' })
end
