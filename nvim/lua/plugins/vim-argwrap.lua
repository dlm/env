return {
    'FooSoft/vim-argwrap',

    keys = {
        { 'gqac', ':ArgWrap<CR>', desc = 'Wrap arguments', silent = true },
    },

    config = function()
        -- vim.keymap.set("n", "gqac", ":ArgWrap<CR>", { silent = true })
        vim.g.argwrap_tail_comma = 1
    end

}
