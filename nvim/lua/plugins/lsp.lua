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
      clangd = {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
      },
      rust_analyzer = {},
      jdtls = {},
    },
  },
  config = function(_, opts)
    -- Ensure mason is set up first
    require("mason").setup()
    -- Mason-LSPConfig v2.0+ setup
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(opts.servers),
      automatic_installation = {
        jdtls = false,
      },
    })
  end
}, {
  -- load luasnips + cmp related in insert mode only
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = { {
    -- snippet plugin
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    opts = {
      history = true,
      updateevents = "TextChanged,TextChangedI",
      -- Prevent potential loops
      region_check_events = "InsertEnter",
      delete_check_events = "InsertLeave"
    },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)

      -- vscode format
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = vim.g.vscode_snippets_path or ""
      }

      -- snipmate format
      require("luasnip.loaders.from_snipmate").load()
      require("luasnip.loaders.from_snipmate").lazy_load {
        paths = vim.g.snipmate_snippets_path or ""
      }

      -- lua format
      require("luasnip.loaders.from_lua").load()
      require("luasnip.loaders.from_lua").lazy_load {
        paths = vim.g.lua_snippets_path or ""
      }

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()] and
              not require("luasnip").session.jump_active then
            require("luasnip").unlink_current()
          end
        end
      })
    end
  },
    { "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path" } }, -- cmp sources plugins
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

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end
      },

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
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(
              vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
              "")
          else
            fallback()
          end
        end, { "i", "s" })
      },
      sources = { {
        name = "nvim_lsp",
        max_item_count = 20,  -- Limit items to prevent hangs
      }, {
        name = "luasnip",
        max_item_count = 10,
      }, {
        name = "buffer",
        max_item_count = 10,
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
        name = "nvim_lua",
        max_item_count = 15,
      }, {
        name = "path",
        max_item_count = 10,
      } }
    }

    return options
  end,
  config = function(_, opts)
    require("cmp").setup(opts)
  end
} }
