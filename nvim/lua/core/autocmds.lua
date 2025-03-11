local opt = vim.opt
local api = vim.api

-- smart relative line numbers

api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function() opt.relativenumber = false end
})

api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function() opt.relativenumber = true end
})

-- clears trailing spaces  

api.nvim_create_autocmd("CursorMoved", {
    callback = function()
        local diagnostics = vim.diagnostic.get(0)
        local cursor = api.nvim_win_get_cursor(0)

        for _, d in ipairs(diagnostics) do
            local lnum = d.lnum + 1

            if d.message:match("Line with trailing space") then
                vim.cmd(lnum .. [[s/\s\+$//e]])
            elseif d.message:match("Line with spaces only") then
                vim.cmd("silent! " .. lnum .. [[s/\s//g]])
            end
        end
        api.nvim_win_set_cursor(0, cursor)
    end,
})

-- autosave

api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    pattern = "*",
    command = "silent! w",
})

-- highlight when yanking

api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- lastplace

api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local last_pos = api.nvim_buf_get_mark(0, '"')
        local line_count = api.nvim_buf_line_count(0)

        if last_pos[1] > 0 and last_pos[1] <= line_count then
            api.nvim_win_set_cursor(0, last_pos)
        end
    end,
})

-- remove numbers from terminal 

api.nvim_create_autocmd("TermOpen", {
    callback = function()
        opt.number = false
        opt.relativenumber = false
    end,
})

