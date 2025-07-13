-- nvim-treesitter configuration

return { {
    -- Treesitter interface
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn"t work on Windows
    build = ":TSUpdate",
    dependencies = { {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
            -- PERF: no need to load the plugin, if we only need its queries for mini.ai
            local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
            local opts = require("lazy.core.plugin").values(plugin, "opts", false)
            local enabled = false
            if opts.textobjects then
                for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
                    if opts.textobjects[mod] and opts.textobjects[mod].enable then
                        enabled = true
                        break
                    end
                end
            end
            if not enabled then
                require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
            end
        end
    } },
    opts = {
        -- A list of parser names, or "all"
        ensure_installed = { "go", "python", "dockerfile", "json", "yaml", "markdown", "html", "scss", "css", "vim", "cpp", "rust" },

        highlight = {
            enable = true,
            use_languagetree = true
        },
        indent = {
            enable = true
        },
        autotag = {
            enable = true
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false
        },
        refactor = {
            highlight_definitions = {
                enable = true,
                -- Clear on cursor move to prevent accumulation
                clear_on_cursor_move = true,
            },
            highlight_current_scope = {
                enable = false
            }
        }
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end
}, {
    -- Treesitter context
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter"
        }
    },
    config = function(_, opts)
        require("treesitter-context").setup({
            enable = true,           -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 3,           -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 6,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 1, -- Maximum number of lines to show for a single context
            trim_scope = 'outer',    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = 'topline',        -- Line used to calculate context. Choices: 'cursor', 'topline'
        })
    end


}
}
