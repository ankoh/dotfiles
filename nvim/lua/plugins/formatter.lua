-- Formatters and linters

return { {
  "mhartington/formatter.nvim",
  config = function()
    local vim = vim
    local formatter = require("formatter")
    local prettierConfig = function()
      return {
        exe = "prettier",
        args = { "--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
        stdin = true
      }
    end

    local formatterConfig = {
      lua = {
        function()
          return {
            exe = "stylua",
            args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "-" },
            stdin = true,
          }
        end,
      },
      vue = { function()
        return {
          exe = "prettier",
          args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote",
            "--parser", "vue" },
          stdin = true
        }
      end },
      scala = {
        function()
          return {
            exe = "scalafmt",
            args = { "--stdout" },
            stdin = true
          }
        end },
      rust = {       -- Rustfmt
        function()
          return {
            exe = "rustfmt",
            args = { "--emit=stdout" },
            stdin = true
          }
        end },
      swift = {       -- Swiftlint
        function()
          return {
            exe = "swift-format",
            args = { vim.api.nvim_buf_get_name(0) },
            stdin = true
          }
        end },
      r = { function()
        return {
          exe = "R",
          args = { "--slave", "--no-restore", "--no-save", "-e",
            '\'con <- file("stdin"); styler::style_text(readLines(con)); close(con)\'', "2>/dev/null" },
          stdin = true
        }
      end },
      dart = { function()
        return {
          exe = "dart",
          args = { 'format' },
          stdin = true
        }
      end },
      ['*'] = {
        -- require("formatter.filetypes.any").lsp_format,
        -- require('formatter.filetypes.any').remove_trailing_whitespace
      }
    }
    local commonFT = { "css", "scss", "html", "java", "javascript", "javascriptreact", "typescript",
      "typescriptreact", "markdown", "markdown.mdx", "xml", "svg", "svelte" }
    for _, ft in ipairs(commonFT) do
      formatterConfig[ft] = { prettierConfig }
    end
    -- Setup functions
    formatter.setup({
      logging = true,
      filetype = formatterConfig,
      log_level = 2
    })
  end
}, {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      markdown = { "vale" }
    }
  end
} }
