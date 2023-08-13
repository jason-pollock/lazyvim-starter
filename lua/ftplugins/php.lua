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
require("intelephense").setup({
    on_attach = function(client, bufnr)
        -- Enable (omnifunc) completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        -- Here we should add additional keymaps and configuration options.
    end,
    flags = {
        debounce_text_changes = 150,
    },
})
-- require("lspconfig").intelephense.setup({
--     on_attach = function(client, bufnr)
--         -- Enable (omnifunc) completion triggered by <c-x><c-o>
--         vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
--         vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--         -- Here we should add additional keymaps and configuration options.
--     end,
--     flags = {
--         debounce_text_changes = 150,
--     },
-- })
