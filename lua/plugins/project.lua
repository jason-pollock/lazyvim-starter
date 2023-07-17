return {
    {
        "ahmedkhalf/project.nvim",
        opts = {},
    },
    {
        "goolord/alpha-nvim",
        opts = function(_, dashboard)
            local button = dashboard.button("p", " " .. " Projects", ":Telescope projects <CR>")
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
            table.insert(dashboard.section.buttons.val, 4, button)
        end,
    },
    {
        "echasnovski/mini.starter",
        optional = true,
        opts = function(_, opts)
            local items = {
                {
                    name = "Projects",
                    action = "Telescope projects",
                    section = string.rep(" ", 22) .. "Telescope",
                },
            }
            vim.list_extend(opts.items, items)
        end,
    },
}
