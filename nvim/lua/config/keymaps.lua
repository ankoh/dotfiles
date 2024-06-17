-- Reload configuration without restart nvim
vim.keymap.set("n", "<leader>r", ":so %<CR>", {})

-- Leave insert mode with jk
vim.keymap.set("i", "jk", "<Esc>", {})

-- Fast qutting and saving
vim.keymap.set("n", "<leader>q", ":qa!<CR>", {})
vim.keymap.set("n", "<leader>s", ":w<CR>", {})

-- Windows
vim.keymap.set("n", "<leader>w", "<C-W>", {})
vim.keymap.set("n", "<C-J>", "<C-w>j", {})
vim.keymap.set("n", "<C-K>", "<C-w>k", {})
vim.keymap.set("n", "<C-L>", "<C-w>l", {})
vim.keymap.set("n", "<C-H>", "<C-w>h", {})
vim.keymap.set("n", "<leader>wh", "<C-w>h", {})
vim.keymap.set("n", "<leader>wj", "<C-w>j", {})
vim.keymap.set("n", "<leader>wk", "<C-w>k", {})
vim.keymap.set("n", "<leader>wl", "<C-w>l", {})
vim.keymap.set("n", "<leader>ws", ":split<CR>", {})
vim.keymap.set("n", "<leader>w+", ":exe \"resize \" . (winheight(0) * 12/10)<CR>", {})
vim.keymap.set("n", "<leader>w-", ":exe \"resize \" . (winheight(0) * 8/10)<CR>", {})
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", {})
vim.keymap.set("n", "<leader>w<", ":exe \"vertical resize \" . (winwidth(0) * 12/10)<CR>", {})
vim.keymap.set("n", "<leader>w>", ":exe \"vertical resize \" . (winwidth(0) * 8/10)<CR>", {})

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>ft", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- NvimTree
vim.keymap.set("n", "<leader>m", ":NvimTreeToggle<CR>", {})    -- open/close
vim.keymap.set("n", "<leader>m", ":NvimTreeToggle<CR>", {})    -- open/close
vim.keymap.set("n", "<leader>mr", ":NvimTreeRefresh<CR>", {})  -- refresh
vim.keymap.set("n", "<leader>mf", ":NvimTreeFindFile<CR>", {}) -- search file

-- Terminal
vim.keymap.set("n", "<leader>tt", ":NeotermToggle<CR>", {})
-- vim.keymap.set("n", "<leader>tx", ":NeotermExit<CR>", {})
