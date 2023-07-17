-- ~/.config/lazyvim/lua/ftplugins/php.lua

-- Set buffer options
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4

-- Mappings
local map = vim.api.nvim_buf_set_keymap
map(0, "n", "<leader>f", ":Format<CR>", { noremap = true })

-- Autocommands
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format({ async = true })
    end,
})

-- Additional config
require("phpactor").setup({})
