-- Highlight on Yank
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])

-- For any questions regarding options
-- You can use command: :opt
vim.g.mapleader = " " -- space leader key
vim.g.maplocalleader = " " -- space leader key

-- Backup
vim.o.swapfile = false -- disable swapfile
vim.o.backup = false -- disable backup on q
vim.o.autoread = true -- auto update file if changed outside of nvim
vim.o.undofile = true -- persistant undo history
vim.o.undolevels = 500 --maximum number of changes that can be undone

-- UI
vim.o.termguicolors = true -- enable 24-bit colors
vim.o.updatetime = 200 -- save swap file with 200ms debouncing
vim.o.number = true -- Show Line Numbers in BUFFER
vim.o.relativenumber = true -- Show Relative Line Numbers in BUFFER
vim.o.splitbelow = true -- better splitting
vim.o.splitright = true -- better splitting
vim.o.cursorline = true -- enable cursor line
vim.o.signcolumn = "yes" -- always show sign column
vim.o.showmode = false -- disable showing mode below statusline
vim.o.laststatus = 3 -- global statusline

-- Controls which characters are used to fill in various UI areas of
-- the editor where there's no actual text.
--
-- It's a comma-separated list of item:char pairs.
-- Common items include:
-- (eob) — character for lines past the end of buffer (default ~)
-- (vert) — vertical split separator
-- (fold) — filler for fold lines
-- (foldopen) / foldclose / foldsep — fold column indicators
-- (diff) — filler lines in diff mode
-- (msgsep) — message separator line
-- (stl / stlnc) — statusline fill (active/inactive)
vim.opt.fillchars = { eob = " " } -- Hides ~ on empty files

-- Search
vim.o.ignorecase = true -- case-insensitive search
vim.o.smartcase = true -- until search pattern contains upper case characters
vim.o.incsearch = true -- enable highlighting search in progress

-- Tabs
vim.o.tabstop = 4 -- how many spaces tab inserts
vim.o.softtabstop = 4 -- how many spaces tab inserts
vim.o.shiftwidth = 4 -- controls number of spaces when using >> or << commands
vim.o.expandtab = true -- use appropriate number of spaces with tab
vim.o.smartindent = true -- indenting correctly after {
vim.o.autoindent = true -- copy indent from current line when starting new line
vim.o.scrolloff = 8 -- always keep 8 lines above/below cursor unless at start/end of file

-- Line Wrap
vim.o.wrap = false -- disable wrapping
vim.o.breakindent = true -- prevent line wrapping

-- Completions
vim.o.completeopt = "menu,menuone,noselect,preview" -- omnicomplete options for popup menu
vim.o.pumheight = 10 -- max height of completion menu
vim.o.winborder = "rounded" -- rounded border

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 0
