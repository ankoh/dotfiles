-- Define autocommands with Lua APIs

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ============================
-- General Autocommands
-- ============================

-- Highlight on yank
autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 1000
        })
    end
})

-- Auto format on save using LSP
autocmd("BufWritePre", {
    desc = "Auto format on save",
    callback = function()
        -- Skip formatting for Java files
        if vim.bo.filetype == "java" then
            return
        end

        -- Check if there are active LSP clients that support formatting
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        local has_formatter = false

        for _, client in pairs(clients) do
            if client.supports_method("textDocument/formatting") then
                has_formatter = true
                break
            end
        end

        if has_formatter then
            vim.lsp.buf.format({ async = false })
        end
    end
})

-- Don't auto comment new lines
autocmd("BufEnter", {
    desc = "Disable auto comment on new lines",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end
})

-- ============================
-- Filetype-specific Settings
-- ============================

-- Set colorcolumn for specific filetypes
autocmd("Filetype", {
    pattern = { "python", "rust", "c", "cpp", "java" },
    desc = "Set colorcolumn for programming languages",
    callback = function()
        vim.opt_local.colorcolumn = "80"
    end
})

-- Enable wrap and spell for text files
autocmd("Filetype", {
    pattern = { "gitcommit", "markdown", "text", "tex" },
    desc = "Enable wrap and spell for text files",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
        vim.opt_local.linebreak = true
    end
})

-- ============================
-- LSP Autocommands
-- ============================

autocmd("LspAttach", {
    group = augroup("UserLspConfig", { clear = true }),
    desc = "Configure LSP keybindings and features when LSP attaches",
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end

        local bufnr = event.buf
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- ============================
        -- LSP Navigation Keymaps
        -- ============================
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("error", opts, { desc = "Go to definition" }))
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("error", opts, { desc = "Go to declaration" }))
        vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("error", opts, { desc = "Go to references" }))
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition,
            vim.tbl_extend("error", opts, { desc = "Go to type definition" }))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
            vim.tbl_extend("error", opts, { desc = "Go to implementation" }))

        -- ============================
        -- LSP Information Keymaps
        -- ============================
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("error", opts, { desc = "Show hover information" }))
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help,
            vim.tbl_extend("error", opts, { desc = "Show signature help" }))

        -- ============================
        -- LSP Action Keymaps
        -- ============================
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("error", opts, { desc = "Rename symbol" }))
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
            vim.tbl_extend("error", opts, { desc = "Code actions" }))
        vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
        end, vim.tbl_extend("error", opts, { desc = "Format buffer" }))

        -- ============================
        -- Diagnostic Keymaps
        -- ============================
        vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist,
            vim.tbl_extend("error", opts, { desc = "Show buffer diagnostics" }))
        vim.keymap.set("n", "<leader>aa", vim.diagnostic.setqflist,
            vim.tbl_extend("error", opts, { desc = "Show all diagnostics" }))
        vim.keymap.set("n", "<leader>ae", function()
            vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
        end, vim.tbl_extend("error", opts, { desc = "Show errors in quickfix" }))
        vim.keymap.set("n", "<leader>aw", function()
            vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
        end, vim.tbl_extend("error", opts, { desc = "Show warnings in quickfix" }))

        -- ============================
        -- LSP Features
        -- ============================

        -- Document highlighting (with throttling to prevent hangs)
        if client and client.supports_method and client.supports_method("textDocument/documentHighlight") then
            local highlight_group = augroup("LspDocumentHighlight", { clear = false })
            local last_highlight_time = 0
            local highlight_debounce = 200 -- 200ms debounce

            autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = bufnr,
                group = highlight_group,
                callback = function()
                    local now = vim.loop.hrtime() / 1000000 -- Convert to milliseconds
                    if now - last_highlight_time > highlight_debounce then
                        last_highlight_time = now
                        -- Check if client is still active before calling
                        local current_clients = vim.lsp.get_clients({ bufnr = bufnr })
                        if #current_clients > 0 then
                            vim.lsp.buf.document_highlight()
                        end
                    end
                end,
            })
            autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = bufnr,
                group = highlight_group,
                callback = function()
                    -- Check if client is still active before calling
                    local current_clients = vim.lsp.get_clients({ bufnr = bufnr })
                    if #current_clients > 0 then
                        vim.lsp.buf.clear_references()
                    end
                end,
            })
        end

        -- Code lens (skip for jdtls as it has its own configuration)
        if client and client.supports_method and client.supports_method("textDocument/codeLens") and client.name ~= "jdtls" then
            local codelens_group = augroup("LspCodeLens", { clear = false })
            autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = bufnr,
                group = codelens_group,
                callback = function()
                    -- Check if client is still active before calling
                    local current_clients = vim.lsp.get_clients({ bufnr = bufnr })
                    if #current_clients > 0 then
                        vim.lsp.codelens.refresh()
                    end
                end,
            })
        end

        -- ============================
        -- Language-specific Keymaps
        -- ============================
        if client.name == "clangd" then
            vim.keymap.set("n", "g<Tab>", "<cmd>ClangdSwitchSourceHeader<CR>",
                vim.tbl_extend("error", opts, { desc = "Switch source/header" }))
        end
    end
})
