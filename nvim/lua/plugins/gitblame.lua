return {
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require('blame').setup {}


      vim.keymap.set("n", "gb", "<cmd>BlameToggle<CR>")
    end,
  },
}
