return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "html",
                "javascript",
                "json",
                "lua",
                "php",
                "phpdoc",
                "query",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            auto_install = true,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        },
        extra_opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, {
                    "typescript",
                    "tsx",
                    "yaml",
                    "json",
                    "json5",
                    "jsonc",
                })
            end
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        opts = nil,
    },
}
