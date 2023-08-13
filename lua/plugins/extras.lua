return {
    {
        "gbprod/yanky.nvim",
        opts = function()
            local mapping = require("yanky.telescope.mapping")
            local mappings = mapping.get_defaults()
            mappings.i["<c-p>"] = nil
            return {
                highlight = { timer = 200 },
                ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
                picker = {
                    telescope = {
                        use_default_mappings = false,
                        mappings = mappings,
                    },
                },
            }
        end,
    },

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
