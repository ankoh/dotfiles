-- General Neovim settings and configuration

local opt = vim.opt
local g = vim.g

-- ============================
-- Leader Key
-- ============================
g.mapleader = ","

-- ============================
-- General Settings
-- ============================
vim.cmd.filetype("plugin indent on")

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.mouse = "a"               -- Enable mouse support
opt.syntax = "enable"
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }

-- ============================
-- Indentation
-- ============================

local indent = 4
opt.autoindent = true    -- Auto indentation
opt.smartindent = true   -- Smart indenting
opt.expandtab = true     -- Convert tabs to spaces
opt.tabstop = indent     -- Number of spaces for a tab
opt.softtabstop = indent -- Backspace removes tab-width spaces
opt.shiftwidth = indent  -- Number of spaces for indentation
opt.shiftround = true    -- Round indent to multiple of shiftwidth

-- ============================
-- Search Settings
-- ============================

opt.hlsearch = true   -- Highlight search matches
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true  -- Smart case sensitivity
opt.wildmenu = true   -- Enhanced command line completion
opt.wildignore:append({ "*/node_modules/*", "*/.git/*", "*/vendor/*" })

-- ============================
-- UI/UX Settings
-- ============================
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.number = true        -- Show line numbers
opt.cursorline = true    -- Highlight current line
opt.signcolumn = "yes"   -- Always show sign column
opt.laststatus = 2       -- Always show status line
opt.showmode = false     -- Don't show mode (handled by statusline)
opt.cmdheight = 0        -- Hide command line when not used
opt.scrolloff = 18       -- Keep lines above/below cursor
opt.sidescrolloff = 3    -- Keep columns left/right of cursor
opt.splitbelow = true    -- Open horizontal splits below
opt.splitright = true    -- Open vertical splits right
opt.wrap = true          -- Wrap long lines

-- List characters for whitespace visualization
opt.list = true
opt.listchars = {
    tab = "┊ ",
    trail = "·",
    extends = "»",
    precedes = "«",
    nbsp = "×"
}

-- ============================
-- File Handling
-- ============================
opt.backup = false      -- Don't create backup files
opt.swapfile = false    -- Don't create swap files
opt.writebackup = false -- Don't backup before overwriting

-- Persistent undo
local undodir = vim.fn.stdpath("data") .. "/undo"
opt.undofile = true    -- Enable persistent undo
opt.undodir = undodir  -- Undo directory
opt.undolevels = 1000  -- Max undo changes
opt.undoreload = 10000 -- Max lines to save for undo

-- ============================
-- Performance
-- ============================
opt.history = 100     -- Command history size
opt.updatetime = 100  -- Faster completion (default: 4000ms)
opt.timeoutlen = 1000 -- Time to wait for mapped sequence
opt.ttimeoutlen = 10  -- Time to wait for key codes
opt.redrawtime = 1500 -- Time to wait for redraw

-- ============================
-- Completion
-- ============================
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append({ c = true }) -- Don't show completion messages

-- ============================
-- Folding
-- ============================
opt.foldmethod = "marker"
opt.foldlevel = 99

-- ============================
-- Disable Built-in Plugins
-- ============================
local disabled_built_ins = {
    "2html_plugin", "getscript", "getscriptPlugin", "gzip", "logipat",
    "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
    "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin",
    "vimball", "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin",
    "synmenu", "optwin", "compiler", "bugreport", "ftplugin"
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

-- ============================
-- Colorscheme
-- ============================
vim.o.background = "dark"
vim.cmd.colorscheme("catppuccin")
