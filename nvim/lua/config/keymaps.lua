-- Keymaps configuration
-- Use `:help vim.keymap.set()` for more info

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key is set in config/init.lua

-- ============================
-- General Keymaps
-- ============================

-- Reload configuration without restart nvim
keymap("n", "<leader>r", ":so %<CR>", opts)

-- Leave insert mode with jk
keymap("i", "jk", "<Esc>", opts)

-- Fast quitting and saving
keymap("n", "<leader>q", ":qa!<CR>", opts)
keymap("n", "<leader>s", ":w<CR>", opts)

-- ============================
-- Window Management
-- ============================

-- Window navigation (Ctrl + hjkl)
keymap("n", "<C-H>", "<C-w>h", opts)
keymap("n", "<C-J>", "<C-w>j", opts)
keymap("n", "<C-K>", "<C-w>k", opts)
keymap("n", "<C-L>", "<C-w>l", opts)

-- Window management with leader
keymap("n", "<leader>w", "<C-W>", opts)
keymap("n", "<leader>wh", "<C-w>h", opts)
keymap("n", "<leader>wj", "<C-w>j", opts)
keymap("n", "<leader>wk", "<C-w>k", opts)
keymap("n", "<leader>wl", "<C-w>l", opts)

-- Window splits
keymap("n", "<leader>ws", ":split<CR>", opts)
keymap("n", "<leader>wv", ":vsplit<CR>", opts)

-- Window resizing
keymap("n", "<leader>w+", ":exe \"resize \" . (winheight(0) * 12/10)<CR>", opts)
keymap("n", "<leader>w-", ":exe \"resize \" . (winheight(0) * 8/10)<CR>", opts)
keymap("n", "<leader>w<", ":exe \"vertical resize \" . (winwidth(0) * 12/10)<CR>", opts)
keymap("n", "<leader>w>", ":exe \"vertical resize \" . (winwidth(0) * 8/10)<CR>", opts)

-- ============================
-- Plugin Keymaps
-- ============================

-- Telescope (fuzzy finder)
keymap("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
keymap("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, { desc = "Live grep" })
keymap("n", "<leader>ft", function() require("telescope.builtin").live_grep() end, { desc = "Live grep (text)" })
keymap("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Find buffers" })
keymap("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Help tags" })

-- NvimTree (file explorer)
keymap("n", "<leader>m", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
keymap("n", "<leader>mr", ":NvimTreeRefresh<CR>", { desc = "Refresh file tree" })
keymap("n", "<leader>mf", ":NvimTreeFindFile<CR>", { desc = "Find file in tree" })

-- Terminal
keymap("n", "<leader>tt", ":NeotermToggle<CR>", { desc = "Toggle terminal" })

-- Git Diffview
keymap("n", "<leader>gv", ":DiffviewOpen<CR>", { desc = "Open diffview" })
keymap("n", "<leader>gc", ":DiffviewClose<CR>", { desc = "Close diffview" })
keymap("n", "<leader>gh", ":DiffviewFileHistory<CR>", { desc = "File history" })
keymap("n", "<leader>gH", ":DiffviewFileHistory %<CR>", { desc = "Current file history" })
keymap("n", "<leader>gR", ":DiffviewRefresh<CR>", { desc = "Refresh diffview" })

-- ============================
-- LSP Keymaps (Global - buffer-local ones are in autocmds.lua)
-- ============================
-- Note: These are fallbacks. Buffer-local keymaps are set when LSP attaches

keymap("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })
keymap("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })

-- ============================
-- Indentation Quick Toggle
-- ============================

-- Function to set indentation for current buffer
local function set_indentation(size)
    vim.bo.expandtab = true
    vim.bo.tabstop = size
    vim.bo.shiftwidth = size
    vim.bo.softtabstop = size
    vim.notify("Indentation set to " .. size .. " spaces", vim.log.levels.INFO)
end

-- Function to set tab indentation
local function set_tab_indentation()
    vim.bo.expandtab = false
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.notify("Indentation set to tabs (4-width)", vim.log.levels.INFO)
end

-- Function to show current indentation settings
local function show_indentation()
    local expandtab = vim.bo.expandtab and "spaces" or "tabs"
    local size = vim.bo.shiftwidth
    vim.notify("Current indentation: " .. expandtab .. " (" .. size .. ")", vim.log.levels.INFO)
end

-- Indentation toggle keymaps
keymap("n", "<leader>i2", function() set_indentation(2) end, { desc = "Set 2-space indentation" })
keymap("n", "<leader>i3", function() set_indentation(3) end, { desc = "Set 3-space indentation" })
keymap("n", "<leader>i4", function() set_indentation(4) end, { desc = "Set 4-space indentation" })
keymap("n", "<leader>it", set_tab_indentation, { desc = "Set tab indentation" })
keymap("n", "<leader>is", show_indentation, { desc = "Show current indentation" })
