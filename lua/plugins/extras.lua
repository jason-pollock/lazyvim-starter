return {
    {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
        keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
        config = true,
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            shell = "zsh",
            direction = "horizontal",
            open_mapping = [[<c-\>]],
        },
        config = true,
    },
}
