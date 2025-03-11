local opt = vim.opt

vim.wo.number = true
opt.relativenumber = true

opt.termguicolors = true
opt.background = "dark"

opt.showmode = false

opt.breakindent = true
-- opt.undofile = true
-- opt.clipboard = "unnamedplus"

opt.incsearch = true

opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = 'yes'

opt.updatetime = 250
opt.timeoutlen = 300

opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window

opt.swapfile = false -- creates a swapfile
opt.cursorline = true -- highlight the current line
opt.scrolloff = 7
opt.sidescrolloff = 7

opt.wrap = false
opt.linebreak = true
opt.mouse = 'a'

opt.autoindent = true
-- opt.smartindent = true

opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true

-- opt.pumheight = 10 -- pop up menu height
-- opt.conceallevel = 0 -- so that `` is visible in markdown files
-- opt.fileencoding = 'utf-8' -- the encoding written to a file
-- opt.cmdheight = 1 -- more space in the neovim command line for displaying messages

-- opt.showtabline = 2 -- always show tabs
-- opt.backspace = 'indent,eol,start' -- allow backspace on

-- folds

opt.foldenable = true
opt.foldlevel = 99
-- opt.foldnestmax = 99
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldcolumn = '1'

