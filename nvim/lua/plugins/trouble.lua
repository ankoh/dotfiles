return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- Configuration options for trouble.nvim
    mode = "workspace_diagnostics",    -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "",                    -- icon used for open folds
    fold_closed = "",                  -- icon used for closed folds
    group = true,                      -- group results by file
    padding = true,                    -- add an extra new line on top of the list
    auto_open = false,                 -- automatically open the list when you have diagnostics
    auto_close = false,                -- automatically close the list when you have no diagnostics
    auto_preview = true,               -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false,                 -- automatically fold a file trouble list at creation
    auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
    include_declaration = {
      "lsp_references", "lsp_implementations", "lsp_definitions"
    }, -- for the given modes, include the declaration of the current symbol in the results
    signs = {
      -- icons / text used for a diagnostic
      error = "",
      warning = "",
      hint = "",
      information = "",
      other = "",
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
  },
  keys = {
    {
      "<leader>dd",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>dD",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>ds",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>dl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>dL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>dQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
