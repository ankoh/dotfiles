-- Description: nvim-tree config
-- disable netrw at the very start of your init.lua (strongly advised)

return { {
    -- File explore
    -- nvim-tree.lua - A file explorer tree for neovim written in lua
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        lazy = true
    },
    opts = {
        filters = {
            dotfiles = false
        },
        update_focused_file = {
            enable = true,
            update_root = false
        },
        view = {
            width = 40,
            side = "left",
            preserve_window_proportions = true
        },
        filesystem_watchers = {
            enable = false
        }
    },
    config = function(_, opts)
        require("nvim-tree").setup(opts)
    end
} }
