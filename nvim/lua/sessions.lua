local M = {}

local session_dir = vim.fn.stdpath("data") .. "/sessions"

local function get_session_file()
    local cwd = vim.fn.getcwd()
    return session_dir .. "/" .. vim.fn.fnamemodify(cwd, ":p:h:t") .. ".vim"
end

function M.save_session()
    if vim.fn.isdirectory(session_dir) == 0 then
        vim.fn.mkdir(session_dir, "p")
    end
    local session_file = get_session_file()
    vim.cmd("mksession! " .. vim.fn.fnameescape(session_file))
end

function M.load_session()
    if vim.fn.argc() == 0 then  -- Only load if no args
        local session_file = get_session_file()
        if vim.fn.filereadable(session_file) == 1 then
            vim.cmd("source " .. vim.fn.fnameescape(session_file))
        end
    end
end

-- Autocommands to handle session saving/loading
vim.api.nvim_create_autocmd("VimLeavePre", { callback = M.save_session })
vim.api.nvim_create_autocmd("VimEnter", { callback = function ()
    vim.schedule(function()
        M.load_session()
    end)
end
})

return M

