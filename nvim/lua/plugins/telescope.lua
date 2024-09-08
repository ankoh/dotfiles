-- nvim-telescope config

return { {
    -- Telescope
    -- Find, Filter, Preview, Pick. All lua, all the time.
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' } },
    config = function(_)
        local telescope = require("telescope")
        telescope.setup({
            pickers = {
                live_grep = {
                    file_ignore_patterns = { 'node_modules/', '.git/', '.venv/' },
                    additional_args = function(_)
                        return { "--hidden" }
                    end
                },
                find_files = {
                    file_ignore_patterns = { 'node_modules/', '.git/', '.venv/' },
                    hidden = true
                },
            },
            extensions = {
                "fzf"
            },
        })
        -- To get fzf loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        telescope.load_extension("fzf")
    end
} }
