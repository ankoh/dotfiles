-- unified.nvim configuration
-- Displays inline unified diffs directly in the buffer, without a separate window

return {
  "axkirillov/unified.nvim",
  cmd = { "Unified", "DiffUnified" },
  init = function()
    -- Alias so the command shows up when prefix-searching ":Diff…"
    vim.api.nvim_create_user_command("DiffUnified", function(cmd)
      vim.cmd("Unified " .. cmd.args)
    end, {
      nargs = "*",
      desc = "Alias for :Unified (inline unified diff)",
    })
  end,
  opts = {
    signs = {
      add = "│",
      delete = "│",
      change = "│",
    },
    highlights = {
      add = "DiffAdd",
      delete = "DiffDelete",
      change = "DiffChange",
    },
    line_symbols = {
      add = "+",
      delete = "-",
      change = "~",
    },
    auto_refresh = true,
    jump_to_first_hunk = true,
    tab = false,
    file_tree = {
      enabled = true,
      width = 30,
      filename_first = true,
      focus = false,
    },
  },
  keys = {
    {
      "<leader>gu",
      "<cmd>Unified<cr>",
      desc = "Unified diff (pick commit)",
    },
    {
      "<leader>gU",
      "<cmd>Unified reset<cr>",
      desc = "Close unified diff",
    },
    {
      "]h",
      function() require("unified.navigation").next_hunk() end,
      desc = "Next hunk (unified)",
    },
    {
      "[h",
      function() require("unified.navigation").previous_hunk() end,
      desc = "Previous hunk (unified)",
    },
  },
}
