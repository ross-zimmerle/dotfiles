-- lua/config/options.lua
-- Options are automatically loaded before lazy.nvim startup
-- Default options: https://neovim.io/doc/user/options.html

local opt = vim.opt

-- Appearance
opt.number = true             -- Show line numbers
opt.relativenumber = true     -- Relative line numbers
opt.cursorline = true         -- Highlight current line
opt.signcolumn = "yes"        -- Always show sign column (prevents text shift)
opt.termguicolors = true      -- True color support

-- Tabs & Indentation
opt.tabstop = 2               -- Number of spaces tabs count for
opt.shiftwidth = 2            -- Size of an indent
opt.expandtab = true          -- Use spaces instead of tabs
opt.smartindent = true        -- Insert indents automatically

-- Search
opt.ignorecase = true         -- Ignore case in search patterns
opt.smartcase = true          -- ...unless uppercase letters are used
opt.hlsearch = true           -- Highlight search results

-- Behavior
opt.scrolloff = 8             -- Lines of context
opt.sidescrolloff = 8         -- Columns of context
opt.mouse = "a"               -- Enable mouse mode
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.undofile = true           -- Persistent undo
opt.updatetime = 250          -- Save swap file and trigger CursorHold faster
opt.timeoutlen = 300          -- Time to wait for a mapped sequence to complete (in ms)
opt.splitright = true         -- Put new windows right of current
opt.splitbelow = true         -- Put new windows below current
opt.wrap = false              -- Disable line wrap
opt.swapfile = false          -- Disable swap file
opt.backup = false            -- Disable backup file

-- Globals
vim.g.mapleader = " "         -- Set leader key to space
vim.g.maplocalleader = " "    -- Set local leader key to space
