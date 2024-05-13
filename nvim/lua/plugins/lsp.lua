-- Enable language servers with the additional completion capabilities offered by nvim-cmp

return { {
    -- Mason
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = {
        PATH = "prepend",
        ui = {
            icons = {
                package_pending = " ",
                package_installed = "󰄳 ",
                package_uninstalled = " 󰚌"
            },

            keymaps = {
                toggle_server_expand = "<CR>",
                install_server = "i",
                update_server = "u",
                check_server_version = "c",
                update_all_servers = "U",
                check_outdated_servers = "C",
                uninstall_server = "X",
                cancel_installation = "<C-c>"
            }
        },

        max_concurrent_installers = 10
    },
    config = function(_, opts)
        require("mason").setup(opts)
    end
}, {
    -- LSP - Quickstart configs for Nvim LSP
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    dependencies = { -- Mason
        -- Portable package manager for Neovim that runs everywhere Neovim runs.
        -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
        { "williamboman/mason.nvim" }, { "williamboman/mason-lspconfig.nvim" }, -- Autocomplete
        -- A completion plugin for neovim coded in Lua.
        {
            "hrsh7th/nvim-cmp",
            dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", "hrsh7th/cmp-buffer" }
        }
    },
    opts = {
        -- Automatically format on save
        autoformat = true,
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
            formatting_options = nil,
            timeout_ms = nil
        },
        -- Enable inlay_hints
        inlay_hints = { enabled = true },
        -- LSP Server Settings
        servers = {
            jsonls = {},
            dockerls = {},
            bashls = {},
            vimls = {},
            clangd = {},
            rust_analyzer = {}
        },
        -- You can do any additional lsp server setup here
        -- return true if you don"t want this server to be setup with lspconfig
        setup = {
            ["*"] = function(server, _) end,
        }
    },
    config = function(_, opts)
        local servers = opts.servers
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

        local function setup(server)
            local server_opts = vim.tbl_deep_extend("force", {
                capabilities = vim.deepcopy(capabilities)
            }, servers[server] or {})

            if opts.setup[server] then
                if opts.setup[server](server, server_opts) then
                    return
                end
            elseif opts.setup["*"] then
                if opts.setup["*"](server, server_opts) then
                    return
                end
            end
            require("lspconfig")[server].setup(server_opts)
        end

        local mlsp = require("mason-lspconfig")
        local available = mlsp.get_available_servers()

        local ensure_installed = {} ---@type string[]
        for server, server_opts in pairs(servers) do
            if server_opts then
                server_opts = server_opts == true and {} or server_opts
                -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                if server_opts.mason == false or not vim.tbl_contains(available, server) then
                    setup(server)
                else
                    ensure_installed[#ensure_installed + 1] = server
                end
            end
        end

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = ensure_installed,
            automatic_installation = true
        })
        require("mason-lspconfig").setup_handlers({ setup })
    end
}, {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
}, {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        { "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path" }
    },
    opts = function()
        local cmp = require "cmp"

        local function border(hl_name)
            return { { "╭", hl_name }, { "─", hl_name }, { "╮", hl_name }, { "│", hl_name }, { "╯", hl_name },
                { "─", hl_name }, { "╰", hl_name }, { "│", hl_name } }
        end

        local options = {
            completion = {
                completeopt = "menu,menuone"
            },

            window = {
                completion = {
                    winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
                    scrollbar = false
                },
                documentation = {
                    border = border "CmpDocBorder",
                    winhighlight = "Normal:CmpDoc"
                }
            },

            snippet = {},

            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                },
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" })
            },
            sources = { {
                name = "nvim_lsp"
            }, {
                name = "buffer",
                option = {
                    -- Avoid accidentally running on big files
                    get_bufnrs = function()
                        local buf = vim.api.nvim_get_current_buf()
                        local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                        if byte_size > 1024 * 1024 then -- 1 Megabyte max
                            return {}
                        end
                        return { buf }
                    end
                }
            }, {
                name = "nvim_lua"
            }, {
                name = "path"
            } }
        }

        return options
    end,
    config = function(_, opts)
        require("cmp").setup(opts)
    end
}
}
