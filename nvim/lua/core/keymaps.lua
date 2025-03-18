local g = vim.g
local api = vim.api
local cmd = vim.cmd

g.mapleader = ' '
g.maplocalleader = ' '

local function map(mode, keybind, action)
    local opts = {noremap = true, silent = true}
    vim.keymap.set(mode, keybind, action, opts)
end

map({'n', 'v'}, '<Space>', '<Nop>')

-- source file

map('n', '<leader>so', '<CMD>source %<CR>')

-- insert --> normal && normal --> insert

map('i', 'jj', '<Esc>')
map('c', 'jj', '<C-c>')
map("t", "jj", [[<C-\><C-n>]])
map('n', 'vb', '<C-q>')
-- map('n', 'vb', '<C-n>')
map('v', 'ff', '<Esc>')

-- weird 

-- map('i', 'kj', '<Esc>j')
-- map('i', 'jk', '<Esc>k')

-- remove search highlights

map('n', 'ff', '<CMD>nohlsearch<CR>')

-- move selected block up/down in visual mode

map("v", "<S-k>", ":m '<-2<CR>gv=gv")
map("v", "<S-j>", ":m '>+1<CR>gv=gv")

-- center when moving up/down the file

map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- center when jumping to next occurences

map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- split buffers vertically and horizontally

map("n", "<leader>v", "<CMD>vsplit<CR>")
map("n", "<leader>h", "<CMD>split<CR>")

--buffer stuff

map("n", "<leader>r", "<CMD>BufferLineCycleNext<CR>")
map("n", "<leader>e", "<CMD>BufferLineCyclePrev<CR>")
map("n", "<leader>q", "<CMD>bd<CR>")
map("n", "<leader>w", "<CMD>enew<CR>")

map("n", "<S-Left>", "<CMD>BufferLineMovePrev<CR>")
map("n", "<S-Right>", "<CMD>BufferLineMoveNext<CR>")

--resize panes

map("n", "<C-Up>", "<CMD>resize +2<CR>")
map("n", "<C-Down>", "<CMD>resize -2<CR>")
map("n", "<C-Left>", "<CMD>vertical resize +2<CR>")
map("n", "<C-Right>", "<CMD>vertical resize -2<CR>")

-- pane navigation

map("n", "<S-h>", "<C-w>h")
map("n", "<S-l>", "<C-w>l")

map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- wrap line

map("n", "<leader>lw", "<CMD>set wrap!<CR>")

-- handy indent

map("n", "<", "<<")
map("n", ">", ">>")

-- stay in visual mode after indenting

map("v", "<", "<gv")
map("v", ">", ">gv")

-- format file

map("n", "<leader>0", "ma gg=G 'a")

-- select entire buffer

map("n", "vae", "ggVG")

-- paste without yanking replaced text (visual mode)

map("v", "p", '"_dP')

-- find and replace

map("n", "mf", function ()
    api.nvim_feedkeys(api.nvim_replace_termcodes(":%s/", true, false, true), "n", false)
end)

-- delete without yanking (visual mode)

map("v", "<leader>d", '"_d')

-- clipboard yank/paste

map("v", "<leader>y", '"+y')
map("n", "<leader>p", '"+p')

-- prevent cursor from jumping back after yanking

map('v', 'y', 'ygv<ESC>')

-- Keep cursor in place when joining lines

map("n", "J", "mzJ`z:delmarks z<cr>")

-- no copy to register during change

map("n", "cc", '"_cc')

-- remap undo from default to U

map("n", "U", "<C-r>")

-- toggle fold

map("n", "zi", "za")

-- find fixme and todo

map("n", "fm", "<CMD>silent! /\\(!FIXME!\\|-- TODO:\\)<CR>")

-- comment and duplicate line

map("n", "dp", function()
    local function get_comment_string()
        return api.nvim_eval("&commentstring"):gsub("%%s", "") or "# "
    end
    local commentstring = get_comment_string()
    local line = api.nvim_get_current_line()
    api.nvim_set_current_line(commentstring .. line)
    local cursor_pos = api.nvim_win_get_cursor(0)
    local row, col = cursor_pos[1], cursor_pos[2]

    api.nvim_buf_set_lines(0, row, row, false, {line})
    api.nvim_win_set_cursor(0, {row + 1, col})
end)

-- start search on very-magic-search 

local function very_magic_search(pattern)
    api.nvim_feedkeys(api.nvim_replace_termcodes(pattern .. "\\V", true, false, true), "n", false)
end

local function normal_regex_search(pattern)
    api.nvim_feedkeys(api.nvim_replace_termcodes(pattern, true, false, true), "n", false)
end

map("n", "/", function() very_magic_search("/") end)
map("n", "?", function() very_magic_search("?") end)

map("n", "<leader>/", function() normal_regex_search("/") end)
map("n", "<leader>?", function() normal_regex_search("?") end)

-- terminal

map("n", "<leader>to", function()
    cmd.vnew()
    cmd.term()
    cmd.wincmd("J")
    api.nvim_win_set_height(0, 6)
    cmd("startinsert")
end)

map("n", "<leader>tl", function()
    local width = math.floor(vim.o.columns * 0.5)
    local height = math.floor(vim.o.lines * 0.35)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local buf = api.nvim_create_buf(false, true)
    local win = api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    cmd("term")
    cmd("startinsert")

    api.nvim_create_autocmd("TermClose", {
        buffer = buf,
        callback = function()
            if api.nvim_win_is_valid(win) then
                api.nvim_win_close(win, true)
            end
        end,
    })
end)

map("t", "<leader>to", [[<C-\><C-n><CMD>bd!<CR>]])
map("t", "<leader>tl", [[<C-\><C-n><CMD>bd!<CR>]])

-- diagnostics

-- map( "n", "[d", vim.diagnostic.goto_prev)
-- map( "n", "]d", vim.diagnostic.goto_next)
-- map( "n", "<leader>e", vim.diagnostic.open_float)
-- map( "n", "<leader>q", vim.diagnostic.setloclist)
