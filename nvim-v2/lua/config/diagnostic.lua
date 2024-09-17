-- Suggestions for displaying diagnostics in a more useful way came from:
--https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#customizing-how-diagnostics-are-displayed

-- Setup the diagnostics to present a sign in the gutter and
-- full text in a popup.
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

-- setup the signs
-- these are using a patched nerd font
local symbols = { Error = "󰅙", Info = "󰋼", Hint = "󰌵", Warn = "" }
for name, icon in pairs(symbols) do
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

-- and the popup
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
    end
})
