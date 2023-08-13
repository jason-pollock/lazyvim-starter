return {
    { "echasnovski/mini.nvim", version = false },

    {
        "echasnovski/mini.pairs",
        opts = {},
    },

    {
        "echasnovski/mini.surround",
        opts = {
            mappings = {
                add = "gza", -- Add surrounding in Normal and Visual modes
                delete = "gzd", -- Delete surrounding
                find = "gzf", -- Find surrounding (to the right)
                find_left = "gzF", -- Find surrounding (to the left)
                highlight = "gzh", -- Highlight surrounding
                replace = "gzr", -- Replace surrounding
                update_n_lines = "gzn", -- Update `n_lines`
            },
        },
    },

    { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },

    {
        "echasnovski/mini.comment",
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring({})
                        or vim.bo.commentstring
                end,
            },
        },
    },

    {
        "echasnovski/mini.ai",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                },
            }
        end,
    },

    {
        "echasnovski/mini.bufremove",
        opts = nil,
    },

    {
        "echasnovski/mini.files",
        opts = {
            windows = {
                width_focus = 30,
                width_preview = 30,
                preview = true,
            },
            options = {
                -- Whether to use for editing directories
                -- Disabled by default in LazyVim because neo-tree is used for that
                use_as_default_explorer = false,
            },
        },
    },

    {
        "echasnovski/mini.indentscope",
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
    },

    {
        "echasnovski/mini.starter",
        opts = function()
            local logo = table.concat({
                "            ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z",
                "            ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    ",
                "            ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       ",
                "            ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         ",
                "            ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           ",
                "            ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           ",
            }, "\n")
            local pad = string.rep(" ", 22)
            local new_section = function(name, action, section)
                return { name = name, action = action, section = pad .. section }
            end

            local starter = require("mini.starter")
            --stylua: ignore
            local config = {
                evaluate_single = true,
                header = logo,
                items = {
                    new_section("Find file",    "Telescope find_files", "Telescope"),
                    new_section("Recent files", "Telescope oldfiles",   "Telescope"),
                    new_section("Grep text",    "Telescope live_grep",  "Telescope"),
                    new_section("init.lua",     "e $MYVIMRC",           "Config"),
                    new_section("Lazy",         "Lazy",                 "Config"),
                    new_section("New file",     "ene | startinsert",    "Built-in"),
                    new_section("Quit",         "qa",                   "Built-in"),
                    new_section("Session restore", [[lua require("persistence").load()]], "Session"),
                },
                content_hooks = {
                    starter.gen_hook.adding_bullet(pad .. "░ ", false),
                    starter.gen_hook.aligning("center", "center"),
                },
            }
            return config
        end,
    },
}
