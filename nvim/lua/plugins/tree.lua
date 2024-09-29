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
            dotfiles = false,
            git_ignored = false
        },
        update_focused_file = {
            enable = true,
            update_root = false
        },
        view = {
            adaptive_size = true,
            side = "left",
            width = 40,
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
