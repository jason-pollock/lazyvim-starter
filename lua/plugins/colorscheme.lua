return {
    -- add gruvbox
    { "ellisonleao/gruvbox.nvim" },

    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = { style = "moon" },
    },

    { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },

    {
        "catppuccin/nvim",
        lazy = true,
        opts = {
            integrations = {
                alpha = true,
                cmp = true,
                gitsigns = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                lsp_trouble = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true },
                neotest = true,
                noice = true,
                notify = true,
                nvimtree = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                which_key = true,
            },
        },
    },

    -- Configure LazyVim to load gruvbox
    {
        "LazyVim/LazyVim",
        opts = {
            -- colorscheme = "catppuccin",
            -- colorscheme = "gruvbox",
            colorscheme = "tokyonight",
            -- colorscheme = "nightfly",
        },
    },
}
