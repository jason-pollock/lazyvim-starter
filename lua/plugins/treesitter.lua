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
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        opts = nil,
    },
}
