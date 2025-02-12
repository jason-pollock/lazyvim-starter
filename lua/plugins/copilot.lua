return {
    {
        "zbirenbaum/copilot.lua",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },

    {
        "zbirenbaum/copilot-cmp",
        opts = {},
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            local Util = require("lazyvim.util")
            local colors = {
                [""] = Util.fg("Special"),
                ["Normal"] = Util.fg("Special"),
                ["Warning"] = Util.fg("DiagnosticError"),
                ["InProgress"] = Util.fg("DiagnosticWarn"),
            }
            table.insert(opts.sections.lualine_x, 2, {
                function()
                    local icon = require("lazyvim.config").icons.kinds.Copilot
                    local status = require("copilot.api").status.data
                    return icon .. (status.message or "")
                end,
                cond = function()
                    local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
                    return ok and #clients > 0
                end,
                color = function()
                    if not package.loaded["copilot"] then
                        return
                    end
                    local status = require("copilot.api").status.data
                    return colors[status.status] or colors[""]
                end,
            })
        end,
    },
}
