return function()
    local status = require'lsp-status'
    status.config {
        current_function = false,
        diagnostics = false,
        show_filename = false,
    }
    status.register_progress()
end
