return function()
    require'nvim-autopairs'.setup { check_ts = true }
    require'cmp'.event:on('confirm_done', require'nvim-autopairs.completion.cmp'.on_confirm_done { map_char = { tex = '' } })
end
