return {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",
    config = function()
        require("scrollview").setup({
            -- Enable the scrollview
            excluded_filetypes = {
                "NvimTree",
                "alpha",
                "dashboard",
                "telescope",
                "packer",
                "lazy",
                "help",
                "man",
                "qf",
                "trouble",
                "notify",
            },
            current_only = true,      -- Show scrollbar only for the current window
            winblend = 75,           -- Transparency of the scrollbar (0-100)
            base = "right",          -- Position: "right" or "left"
            column = 1,              -- Offset from the window edge
            signs_on_startup = {},   -- Disable signs by default
            diagnostics_severities = { vim.diagnostic.severity.ERROR },
            mode = "simple",         -- Display mode: "simple" or "signs"
            
            -- Appearance settings
            scrollview_character = "┃",  -- Character used for the scrollbar
            scrollview_signs_column = true,
            scrollview_diagnostics = true,
            scrollview_cursor = true,
            
            -- Colors (will use theme colors by default)
            -- scrollview_highlight = "ScrollView",
            -- scrollview_cursor_highlight = "ScrollViewCursor",
        })
    end,
}
