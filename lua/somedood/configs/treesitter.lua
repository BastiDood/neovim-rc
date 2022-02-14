return function()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            'c',
            'cmake',
            'comment',
            'cpp',
            'css',
            'html',
            'javascript',
            'jsdoc',
            'jsonc',
            'latex',
            'lua',
            'markdown',
            'python',
            'rust',
            'toml',
            'tsx',
            'typescript',
            'verilog',
            'yaml',
        },
        indent = { enable = true },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    }
end
