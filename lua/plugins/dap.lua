return {
    {
        "mfussenegger/nvim-dap",
        opts = {},
    },
    {
        "rcarriga/nvim-dap-ui",
        opts = {},
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
    },
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            defaults = {
                ["<leader>d"] = { name = "+debug" },
                ["<leader>da"] = { name = "+adapters" },
            },
        },
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_installation = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
            },
        },
    },
}
