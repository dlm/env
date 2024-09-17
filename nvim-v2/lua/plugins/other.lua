return {
    "rgroli/other.nvim",

    keys = {
        {
            "<leader>a",
            ":OtherVSplit<CR>",
            desc = "Open [a]lternate file in a vertical split",
            silent = true
        },
    },

    config = function()
        require("other-nvim").setup({ mappings = { "golang" } })
    end,
}
