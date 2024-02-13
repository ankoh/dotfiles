-- Pacman config for lualine

return { {
    "linrongbin16/lsp-progress.nvim",
    name = "lsp-progress",
    config = function()
        require('lsp-progress').setup()
    end
}, {
    -- Statusline
    -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "catppuccin",
        "lsp-progress",
    },
    config = function(_)
        local lualine = require("lualine")
        local lsp = require("lsp-progress")
        local config = {
            options = {
                theme = "catppuccin",

                icons_enabled = true,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                    "Lazy",
                    "NvimTree"
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
        lualine.setup(config)

        -- listen lsp-progress event and refresh lualine
        vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = "lualine_augroup",
            pattern = "LspProgressStatusUpdated",
            callback = require("lualine").refresh,
        })
    end
} }
