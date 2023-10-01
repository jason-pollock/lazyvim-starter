-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Set default indent to 4 spaces
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.tabstop = 4 -- Number of spaces tabs count for

-- Filetype specific overrides
vim.api.nvim_create_autocmd("FileType", {
    pattern = "php",
    callback = function()
        vim.bo.shiftwidth = 4
        vim.bo.tabstop = 4
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "json" },
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
    end,
})

-- Shamelessly stolen from https://dev.to/vonheikemen/lazynvim-how-to-revert-a-plugin-back-to-a-previous-version-1pdp
-- Create a copy of the lockfile with a time and date as the name. This gets executed before lazy.nvim updates plugins.
-- If something goes wrong, use the command :BrowseSnapshots to search for the latest lockfile.
-- Grab the commit of the plugin that broke my config, then copy it to the current lockfile.
-- After that, use the restore command with the name of the plugin.
-- Ex: :Lazy restore some-plugin
-- If something went really really bad, just copy the whole backup and replace the current lockfile.
local lazy_cmds = vim.api.nvim_create_augroup("lazy_cmds", { clear = true })
local snapshot_dir = vim.fn.stdpath("data") .. "/plugin-snapshot"
local lock = vim.fn.stdpath("config") .. "/lazy-lock.json"

vim.api.nvim_create_user_command("BrowseSnapshots", "edit " .. snapshot_dir, {})

vim.api.nvim_create_autocmd("User", {
    group = lazy_cmds,
    pattern = "LazyUpdatePre",
    desc = "Backup lazy.nvim lockfile",
    callback = function(event)
        vim.fn.mkdir(snapshot_dir, "p")
        local snapshot = snapshot_dir .. os.date("/%Y-%m-%dT%H:%M:%S.json")

        vim.loop.fs_copyfile(lock, snapshot)
    end,
})

--
vim.api.nvim_create_autocmd("User", {
    pattern = "LazySync",
    callback = function()
        local uv = vim.loop

        local config = vim.fn.stdpath("config")
        local NUM_BACKUPS = 5
        local LOCKFILES_DIR = string.format("%s/lockfiles/", config)

        -- create if not existing
        if not uv.fs_stat(LOCKFILES_DIR) then
            uv.fs_mkdir(LOCKFILES_DIR, 448)
        end

        local lockfile = require("lazy.core.config").options.lockfile
        if uv.fs_stat(lockfile) then
            -- create "%Y%m%d_%H:%M:%s_lazy-lock.json" in lockfile folder
            local filename = string.format("%s_lazy-lock.json", os.date("%Y%m%d_%H:%M:%S"))
            local backup_lock = string.format("%s/%s", LOCKFILES_DIR, filename)
            local success = uv.fs_copyfile(lockfile, backup_lock)
            if success then
                -- clean up backups in excess of `num_backups`
                local iter_dir = uv.fs_scandir(LOCKFILES_DIR)
                if iter_dir then
                    local suffix = "lazy-lock.json"
                    local backups = {}
                    while true do
                        local name = uv.fs_scandir_next(iter_dir)
                        -- make sure we are deleting lockfiles
                        if name and name:sub(-#suffix, -1) == suffix then
                            table.insert(backups, string.format("%s/%s", LOCKFILES_DIR, name))
                        end
                        if name == nil then
                            break
                        end
                    end
                    if not vim.tbl_isempty(backups) and #backups > NUM_BACKUPS then
                        -- remove the lockfiles
                        for _ = 1, #backups - NUM_BACKUPS do
                            uv.fs_unlink(table.remove(backups, 1))
                        end
                    end
                end
            end
            vim.notify(string.format("Backed up %s", filename), vim.log.levels.INFO, { title = "lazy.nvim" })
        end
    end,
})
