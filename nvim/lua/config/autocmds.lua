-- Define autocommands with Lua APIs

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- General settings

-- Highlight on yank
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = "1000"
        })
    end
})

-- Remove whitespace on save
-- This is cool, but also inflates the diffs quite a bit sometimes
-- autocmd("BufWritePre", {
--     pattern = "",
--     command = ":%s/\\s\\+$//e"
-- })

-- Auto format on save using the attached (optionally filtered) language servere clients
-- https://neovim.io/doc/user/lsp.html#vim.lsp.buf.format()
autocmd("BufWritePre", {
    pattern = "",
    command = ":silent lua vim.lsp.buf.format()"
})

-- Don"t auto commenting new lines
autocmd("BufEnter", {
    pattern = "",
    command = "set fo-=c fo-=r fo-=o"
})

autocmd("Filetype", {
    pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml", "lua" },
    command = "setlocal shiftwidth=4 tabstop=4"
})

-- Set colorcolumn
autocmd("Filetype", {
    pattern = { "python", "rst", "c", "cpp" },
    command = "set colorcolumn=80"
})

autocmd("Filetype", {
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})

autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client == nil then
            return
        end

        -- Highlight references
        if client.supports_method("textDocument/documentHighlight") then
            vim.api.nvim_create_autocmd("CursorHold", {
                callback = vim.lsp.buf.document_highlight,
                buffer = ev.buf,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                callback = vim.lsp.buf.clear_references,
                buffer = ev.buf,
            })
        end
        if client.supports_method("textDocument/codeLens") then
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                callback = vim.lsp.codelens.refresh,
                buffer = ev.buf,
            })
        end


        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, noremap = true }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist)
        vim.keymap.set('n', '<leader>aa', vim.diagnostic.setqflist)
        vim.keymap.set('n', '<leader>ae', function()
            vim.diagnostic.setqflist({ severity = "E" })
        end)
        vim.keymap.set('n', '<leader>aw', function()
            vim.diagnostic.setqflist({ severity = "W" })
        end)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        -- vim.keymap.set('v', '<leader>f', vim.lsp.buf.range_formatting)

        -- Enable inlay hints if the server supports them
        -- if client.server_capabilities.inlayHintProvider then
        --     vim.lsp.buf.inlay_hint(ev.buf, true)
        -- end

        -- clangd-specific key bindings
        if client.name == "clangd" then
            vim.keymap.set('n', 'g<Tab>', "<cmd>ClangdSwitchSourceHeader<CR>")
        end
    end
})
