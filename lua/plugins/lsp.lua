return {
    {
        "neovim/nvim-lspconfig",
        -- LSP Keymaps (https://www.lazyvim.org/plugins/lsp)
        init = function()
            -- local keys = require("lazyvim.plugins.lsp.keymaps").get()
            -- change a keymap
            -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
            -- disable a keymap
            -- keys[#keys + 1] = { "K", false }
            -- add a keymap
            -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
        end,
        opts = {
            -- options for vim.diagnostic.config()
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    -- prefix = "●",
                    -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                    -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                    prefix = "icons",
                },
                severity_sort = true,
            },
            -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            -- provide the inlay hints.
            inlay_hints = {
                enabled = true,
            },
            -- add any global capabilities here
            capabilities = {},
            -- Automatically format on save
            autoformat = true,
            -- Enable this to show formatters used in a notification
            -- Useful for debugging formatter issues
            format_notify = false,
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overridden when specified
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            -- LSP Server Settings
            ---@type lspconfig.options
            servers = {
                psalm = {},
                phpactor = {},
                intelephense = {
                    settings = {
                        intelephense = {
                            stubs = {
                                "apache",
                                "bcmath",
                                "bz2",
                                "calendar",
                                "com_dotnet",
                                "com_dotnet",
                                "Core",
                                "ctype",
                                "curl",
                                "date",
                                "dba",
                                "dom",
                                "enchant",
                                "exif",
                                "FFI",
                                "fileinfo",
                                "filter",
                                "fpm",
                                "ftp",
                                "gd",
                                "gettext",
                                "gmp",
                                "hash",
                                "iconv",
                                "imap",
                                "intl",
                                "json",
                                "ldap",
                                "libxml",
                                "mbstring",
                                "meta",
                                "mysqli",
                                "oci8",
                                "odbc",
                                "openssl",
                                "pcntl",
                                "pcre",
                                "PDO",
                                "pdo_ibm",
                                "pdo_mysql",
                                "pdo_pgsql",
                                "pdo_sqlite",
                                "pgsql",
                                "Phar",
                                "posix",
                                "pspell",
                                "readline",
                                "Reflection",
                                "session",
                                "shmop",
                                "SimpleXML",
                                "snmp",
                                "soap",
                                "sockets",
                                "sodium",
                                "SPL",
                                "sqlite3",
                                "standard",
                                "superglobals",
                                "sysvmsg",
                                "sysvsem",
                                "sysvshm",
                                "tidy",
                                "tokenizer",
                                "xml",
                                "xmlreader",
                                "xmlrpc",
                                "xmlwriter",
                                "xsl",
                                "Zend OPcache",
                                "zip",
                                "zlib",
                                "wordpress",
                                "phpunit",
                            },
                            diagnostics = {
                                enable = true,
                            },
                        },
                    },
                },
                jsonls = {
                    -- lazy-load schemastore when needed
                    on_new_config = function(new_config)
                        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
                        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
                    end,
                    settings = {
                        json = {
                            format = {
                                enable = true,
                            },
                            validate = { enable = true },
                        },
                    },
                },
                eslint = {
                    settings = {
                        -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
                        workingDirectory = { mode = "auto" },
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
                yamlls = {
                    -- Have to add this for yamlls to understand that we support line folding
                    capabilities = {
                        textDocument = {
                            foldingRange = {
                                dynamicRegistration = false,
                                lineFoldingOnly = true,
                            },
                        },
                    },
                    -- lazy-load schemastore when needed
                    on_new_config = function(new_config)
                        new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
                        vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
                    end,
                    settings = {
                        redhat = { telemetry = { enabled = false } },
                        yaml = {
                            keyOrdering = false,
                            format = {
                                enable = true,
                            },
                            validate = true,
                            schemaStore = {
                                -- Must disable built-in schemaStore support to use
                                -- schemas from SchemaStore.nvim plugin
                                enable = false,
                                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                                url = "",
                            },
                        },
                    },
                },
            },
            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
                eslint = function()
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        callback = function(event)
                            if not require("lazyvim.plugins.lsp.format").enabled() then
                                -- exit early if autoformat is not enabled
                                return
                            end

                            local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
                            if client then
                                local diag = vim.diagnostic.get(
                                    event.buf,
                                    { namespace = vim.lsp.diagnostic.get_namespace(client.id) }
                                )
                                if #diag > 0 then
                                    vim.cmd("EslintFixAll")
                                end
                            end
                        end,
                    })
                end,
                -- example to setup with typescript.nvim
                tsserver = function(_, opts)
                    require("typescript").setup({ server = opts })
                    return true
                end,
                -- Specify * to use this function as a fallback for any server
                -- ["*"] = function(server, opts) end,
            },
        },
    },

    { import = "lazyvim.plugins.extras.lang.typescript" },

    { "folke/neoconf.nvim", opts = {} },

    { "folke/neodev.nvim", opts = {} },

    { "williamboman/mason-lspconfig.nvim", opts = nil },

    {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
            return require("lazyvim.util").has("nvim-cmp")
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        opts = function()
            local nls = require("null-ls")
            return {
                root_dir = require("null-ls.utils").root_pattern("composer.json", ".git", "package.json", "Makefile"),
                sources = {
                    -- Eslint
                    nls.builtins.code_actions.eslint_d,
                    nls.builtins.formatting.eslint_d.with({
                        condition = function(utils)
                            return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
                        end,
                    }),
                    nls.builtins.diagnostics.eslint_d.with({
                        condition = function(utils)
                            return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
                        end,
                    }),

                    -- Markdown
                    nls.builtins.formatting.markdownlint,
                    nls.builtins.diagnostics.markdownlint.with({
                        extra_args = { "--disable", "line-length" },
                    }),

                    -- Spelling
                    -- nls.builtins.diagnostics.prettierd,
                    nls.builtins.completion.spell,
                    nls.builtins.code_actions.cspell,
                    nls.builtins.diagnostics.cspell,
                    nls.builtins.diagnostics.shellcheck,

                    -- PHP
                    nls.builtins.diagnostics.phpcs.with({ -- Change how the php linting will work
                        prefer_local = "vendor/bin",
                        diagnostics_format = "#{m} (#{c}) [#{s}]", -- Makes PHPCS errors more readeable
                    }),
                    nls.builtins.formatting.phpcbf.with({ -- Use the local installation first
                        prefer_local = "vendor/bin",
                    }),

                    nls.builtins.formatting.stylua,
                    nls.builtins.formatting.shfmt,
                },
            }
        end,
    },
}
