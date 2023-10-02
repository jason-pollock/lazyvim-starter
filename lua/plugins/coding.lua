return {
    {
        "L3MON4D3/LuaSnip",
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
    },
    {
        "rafamadriz/friendly-snippets",
        opts = {},
    },
    {
        "williamboman/mason.nvim",
        opts = {
            -- THIS IS A COOL WAY TO ADD SOMETHING TO AN ARRAY IN LUA
            -- function(_, opts)
            --     table.insert(opts.ensure_installed, "prettierd")
            -- end,
            ensure_installed = {
                "stylua",
                "shellcheck",
                "intelephense",
                "php-cs-fixer",
                "shfmt",
            },
        },
    },
    {
        "nvim-pack/nvim-spectre",
        config = true,
    },
}
