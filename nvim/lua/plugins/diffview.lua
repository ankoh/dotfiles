-- Diffview configuration
-- A single tabpage interface for easily cycling through diffs for all modified files for any git rev

return {
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory"
    },
    opts = {
      diff_binaries = false,    -- Show diffs for binaries
      enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
      git_cmd = { "git" },      -- The git executable followed by default args.
      use_icons = true,         -- Requires nvim-web-devicons
      show_help_hints = true,   -- Show help hints in the wild menu
      watch_index = true,       -- Update views and index on git index changes
      icons = {                 -- Only applies when use_icons is true.
        folder_closed = "",
        folder_open = "",
      },
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
      view = {
        -- Configure the layout and behavior of different types of views.
        default = {
          -- Config for changed files, and staged files in diff views.
          layout = "diff2_horizontal",
          winbar_info = false,          -- See ':h diffview-config-view.x.winbar_info'
        },
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase.
          layout = "diff3_horizontal",
          disable_diagnostics = true,   -- Temporarily disable diagnostics for conflict buffers while in the view.
          winbar_info = true,           -- See ':h diffview-config-view.x.winbar_info'
        },
        file_history = {
          -- Config for changed files in file history views.
          layout = "diff2_horizontal",
          winbar_info = false,          -- See ':h diffview-config-view.x.winbar_info'
        },
      },
      file_panel = {
        listing_style = "tree",             -- One of 'list' or 'tree'
        tree_options = {                    -- Only applies when listing_style is 'tree'
          flatten_dirs = true,              -- Flatten dirs that only contain one single dir
          folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
        },
        win_config = {                      -- See ':h diffview-config-win_config'
          position = "left",
          width = 35,
          win_opts = {}
        },
      },
      file_history_panel = {
        log_options = {   -- See ':h diffview-config-log_options'
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
        win_config = {    -- See ':h diffview-config-win_config'
          position = "bottom",
          height = 16,
          win_opts = {}
        },
      },
      commit_log_panel = {
        win_config = {   -- See ':h diffview-config-win_config'
          win_opts = {},
        }
      },
      default_args = {    -- Default args prepended to the arg-list for the listed commands
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },
      hooks = {},         -- See ':h diffview-config-hooks'
      keymaps = {
        disable_defaults = false, -- Disable the default keymaps
        view = {
          -- The `view` bindings are active in the diff buffers, only when the current
          -- tabpage is a Diffview.
          {
            "n",
            "<tab>",
            "<cmd>DiffviewToggleFiles<cr>",
            { desc = "Toggle the file panel." }
          },
          {
            "n", 
            "gf",
            "<cmd>DiffviewToggleFiles<cr>",
            { desc = "Toggle the file panel" }
          },
          {
            "n",
            "<leader>e",
            "<cmd>DiffviewToggleFiles<cr>",
            { desc = "Toggle the file panel" }
          },
          {
            "n",
            "<leader>co",
            "<cmd>DiffviewClose<cr>",
            { desc = "Close diffview tab" }
          },
        },
        diff1 = {
          -- Mappings in single pane diff layouts
          {
            "n",
            "g?",
            "<cmd>h diffview-maps-diff1<cr>",
            { desc = "Open the help panel" }
          },
        },
        diff2 = {
          -- Mappings in 2-pane diff layouts
          {
            "n",
            "g?",
            "<cmd>h diffview-maps-diff2<cr>",
            { desc = "Open the help panel" }
          },
        },
        diff3 = {
          -- Mappings in 3-pane diff layouts
          {
            "n",
            "g?",
            "<cmd>h diffview-maps-diff3<cr>",
            { desc = "Open the help panel" }
          },
        },
        diff4 = {
          -- Mappings in 4-pane diff layouts
          {
            "n",
            "g?",
            "<cmd>h diffview-maps-diff4<cr>",
            { desc = "Open the help panel" }
          },
        },
        file_panel = {
          {
            "n",
            "j",
            "<cmd>lua require'diffview.actions'.next_entry()<cr>",
            { desc = "Bring the cursor to the next file entry" }
          },
          {
            "n",
            "<down>",
            "<cmd>lua require'diffview.actions'.next_entry()<cr>",
            { desc = "Bring the cursor to the next file entry" }
          },
          {
            "n",
            "k",
            "<cmd>lua require'diffview.actions'.prev_entry()<cr>",
            { desc = "Bring the cursor to the previous file entry" }
          },
          {
            "n",
            "<up>",
            "<cmd>lua require'diffview.actions'.prev_entry()<cr>",
            { desc = "Bring the cursor to the previous file entry" }
          },
          {
            "n",
            "<cr>",
            "<cmd>lua require'diffview.actions'.select_entry()<cr>",
            { desc = "Open the diff for the selected entry" }
          },
          {
            "n",
            "o",
            "<cmd>lua require'diffview.actions'.select_entry()<cr>",
            { desc = "Open the diff for the selected entry" }
          },
          {
            "n",
            "<2-LeftMouse>",
            "<cmd>lua require'diffview.actions'.select_entry()<cr>",
            { desc = "Open the diff for the selected entry" }
          },
          {
            "n",
            "-",
            "<cmd>lua require'diffview.actions'.toggle_stage_entry()<cr>",
            { desc = "Stage / unstage the selected entry" }
          },
          {
            "n",
            "S",
            "<cmd>lua require'diffview.actions'.stage_all()<cr>",
            { desc = "Stage all entries" }
          },
          {
            "n",
            "U",
            "<cmd>lua require'diffview.actions'.unstage_all()<cr>",
            { desc = "Unstage all entries" }
          },
          {
            "n",
            "X",
            "<cmd>lua require'diffview.actions'.restore_entry()<cr>",
            { desc = "Restore entry to the state on the left side" }
          },
          {
            "n",
            "L",
            "<cmd>lua require'diffview.actions'.open_commit_log()<cr>",
            { desc = "Open the commit log panel" }
          },
          {
            "n",
            "zo",
            "<cmd>lua require'diffview.actions'.open_fold()<cr>",
            { desc = "Expand fold" }
          },
          {
            "n",
            "h",
            "<cmd>lua require'diffview.actions'.close_fold()<cr>",
            { desc = "Collapse fold" }
          },
          {
            "n",
            "zc",
            "<cmd>lua require'diffview.actions'.close_fold()<cr>",
            { desc = "Collapse fold" }
          },
          {
            "n",
            "za",
            "<cmd>lua require'diffview.actions'.toggle_fold()<cr>",
            { desc = "Toggle fold" }
          },
          {
            "n",
            "zR",
            "<cmd>lua require'diffview.actions'.open_all_folds()<cr>",
            { desc = "Expand all folds" }
          },
          {
            "n",
            "zM",
            "<cmd>lua require'diffview.actions'.close_all_folds()<cr>",
            { desc = "Collapse all folds" }
          },
          {
            "n",
            "<c-b>",
            "<cmd>lua require'diffview.actions'.scroll_view(-0.25)<cr>",
            { desc = "Scroll the view up" }
          },
          {
            "n",
            "<c-f>",
            "<cmd>lua require'diffview.actions'.scroll_view(0.25)<cr>",
            { desc = "Scroll the view down" }
          },
          {
            "n",
            "<tab>",
            "<cmd>lua require'diffview.actions'.select_next_entry()<cr>",
            { desc = "Open the diff for the next file" }
          },
          {
            "n",
            "<s-tab>",
            "<cmd>lua require'diffview.actions'.select_prev_entry()<cr>",
            { desc = "Open the diff for the previous file" }
          },
          {
            "n",
            "gf",
            "<cmd>lua require'diffview.actions'.goto_file()<cr>",
            { desc = "Open the file in the previous tabpage" }
          },
          {
            "n",
            "<C-w><C-f>",
            "<cmd>lua require'diffview.actions'.goto_file_split()<cr>",
            { desc = "Open the file in a new split" }
          },
          {
            "n",
            "<C-w>gf",
            "<cmd>lua require'diffview.actions'.goto_file_tab()<cr>",
            { desc = "Open the file in a new tabpage" }
          },
          {
            "n",
            "i",
            "<cmd>lua require'diffview.actions'.listing_style()<cr>",
            { desc = "Toggle between 'list' and 'tree' views" }
          },
          {
            "n",
            "f",
            "<cmd>lua require'diffview.actions'.toggle_flatten_dirs()<cr>",
            { desc = "Flatten empty subdirectories in tree listing style" }
          },
          {
            "n",
            "R",
            "<cmd>lua require'diffview.actions'.refresh_files()<cr>",
            { desc = "Update stats and entries in the file list" }
          },
          {
            "n",
            "<leader>e",
            "<cmd>lua require'diffview.actions'.focus_files()<cr>",
            { desc = "Bring focus to the file panel" }
          },
          {
            "n",
            "<leader>b",
            "<cmd>lua require'diffview.actions'.toggle_files()<cr>",
            { desc = "Toggle the file panel" }
          },
          {
            "n",
            "g<C-x>",
            "<cmd>lua require'diffview.actions'.cycle_layout()<cr>",
            { desc = "Cycle through available layouts" }
          },
          {
            "n",
            "[x",
            "<cmd>lua require'diffview.actions'.prev_conflict()<cr>",
            { desc = "In the merge-tool: jump to the previous conflict" }
          },
          {
            "n",
            "]x",
            "<cmd>lua require'diffview.actions'.next_conflict()<cr>",
            { desc = "In the merge-tool: jump to the next conflict" }
          },
          {
            "n",
            "g?",
            "<cmd>h diffview-maps-file-panel<cr>",
            { desc = "Open the help panel" }
          },
        },
        file_history_panel = {
          {
            "n",
            "g!",
            "<cmd>lua require'diffview.actions'.options()<cr>",
            { desc = "Open the option panel" }
          },
          {
            "n",
            "<C-A-d>",
            "<cmd>lua require'diffview.actions'.open_in_diffview()<cr>",
            { desc = "Open the entry under the cursor in a diffview" }
          },
          {
            "n",
            "y",
            "<cmd>lua require'diffview.actions'.copy_hash()<cr>",
            { desc = "Copy the commit hash of the entry under the cursor" }
          },
          {
            "n",
            "L",
            "<cmd>lua require'diffview.actions'.open_commit_log()<cr>",
            { desc = "Show commit details" }
          },
          {
            "n",
            "zR",
            "<cmd>lua require'diffview.actions'.open_all_folds()<cr>",
            { desc = "Expand all folds" }
          },
          {
            "n",
            "zM",
            "<cmd>lua require'diffview.actions'.close_all_folds()<cr>",
            { desc = "Collapse all folds" }
          },
          {
            "n",
            "j",
            "<cmd>lua require'diffview.actions'.next_entry()<cr>",
            { desc = "Bring the cursor to the next file entry" }
          },
          {
            "n",
            "<down>",
            "<cmd>lua require'diffview.actions'.next_entry()<cr>",
            { desc = "Bring the cursor to the next file entry" }
          },
          {
            "n",
            "k",
            "<cmd>lua require'diffview.actions'.prev_entry()<cr>",
            { desc = "Bring the cursor to the previous file entry" }
          },
          {
            "n",
            "<up>",
            "<cmd>lua require'diffview.actions'.prev_entry()<cr>",
            { desc = "Bring the cursor to the previous file entry" }
          },
          {
            "n",
            "<cr>",
            "<cmd>lua require'diffview.actions'.select_entry()<cr>",
            { desc = "Open the diff for the selected entry" }
          },
          {
            "n",
            "o",
            "<cmd>lua require'diffview.actions'.select_entry()<cr>",
            { desc = "Open the diff for the selected entry" }
          },
          {
            "n",
            "<2-LeftMouse>",
            "<cmd>lua require'diffview.actions'.select_entry()<cr>",
            { desc = "Open the diff for the selected entry" }
          },
          {
            "n",
            "<c-b>",
            "<cmd>lua require'diffview.actions'.scroll_view(-0.25)<cr>",
            { desc = "Scroll the view up" }
          },
          {
            "n",
            "<c-f>",
            "<cmd>lua require'diffview.actions'.scroll_view(0.25)<cr>",
            { desc = "Scroll the view down" }
          },
          {
            "n",
            "<tab>",
            "<cmd>lua require'diffview.actions'.select_next_entry()<cr>",
            { desc = "Open the diff for the next file" }
          },
          {
            "n",
            "<s-tab>",
            "<cmd>lua require'diffview.actions'.select_prev_entry()<cr>",
            { desc = "Open the diff for the previous file" }
          },
          {
            "n",
            "gf",
            "<cmd>lua require'diffview.actions'.goto_file()<cr>",
            { desc = "Open the file in the previous tabpage" }
          },
          {
            "n",
            "<C-w><C-f>",
            "<cmd>lua require'diffview.actions'.goto_file_split()<cr>",
            { desc = "Open the file in a new split" }
          },
          {
            "n",
            "<C-w>gf",
            "<cmd>lua require'diffview.actions'.goto_file_tab()<cr>",
            { desc = "Open the file in a new tabpage" }
          },
          {
            "n",
            "<leader>e",
            "<cmd>lua require'diffview.actions'.focus_files()<cr>",
            { desc = "Bring focus to the file panel" }
          },
          {
            "n",
            "<leader>b",
            "<cmd>lua require'diffview.actions'.toggle_files()<cr>",
            { desc = "Toggle the file panel" }
          },
          {
            "n",
            "g<C-x>",
            "<cmd>lua require'diffview.actions'.cycle_layout()<cr>",
            { desc = "Cycle through available layouts" }
          },
          {
            "n",
            "g?",
            "<cmd>h diffview-maps-file-history-panel<cr>",
            { desc = "Open the help panel" }
          },
        },
        option_panel = {
          {
            "n",
            "<tab>",
            "<cmd>lua require'diffview.actions'.select_entry()<cr>",
            { desc = "Change the current option" }
          },
          {
            "n",
            "q",
            "<cmd>lua require'diffview.actions'.close()<cr>",
            { desc = "Close the panel" }
          },
          {
            "n",
            "g?",
            "<cmd>h diffview-maps-option-panel<cr>",
            { desc = "Open the help panel" }
          },
        },
        help_panel = {
          {
            "n",
            "q",
            "<cmd>lua require'diffview.actions'.close()<cr>",
            { desc = "Close help menu" }
          },
          {
            "n",
            "<esc>",
            "<cmd>lua require'diffview.actions'.close()<cr>",
            { desc = "Close help menu" }
          },
        },
      },
    },
  }
}
