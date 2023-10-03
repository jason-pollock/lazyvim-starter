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
    {
        "stevearc/conform.nvim",
        opts = {
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_fallback = true,
            },
            formatters_by_ft = {
                lua = { "stylua " },
                -- Multiple formatters sequentially
                python = { "isort", "black" },
                -- Use a sublist to run only the first available formatter
                javascript = { { "prettierd", "prettier" } },
                bash = { "shellcheck", "beautysh", "shellharden", "shfmt" },
                php = { "php-cs-fixer" },
                json = { "jq" },
                markdown = { "markdownlint" },
                css = { "stylelint" },
                yaml = { { "yamlfmt", "yamlfix" } },
                ["*"] = { "codespell" },
            },
        },
    },
}
