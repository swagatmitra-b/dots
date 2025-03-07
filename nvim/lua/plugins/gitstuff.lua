return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            -- "sindrets/diffview.nvim",        -- optional - Diff integration 
        },
        config = function ()
            require("neogit").setup({
                vim.keymap.set("n", "<leader>gg", "<CMD>Neogit kind=floating<CR>", {silent = true, noremap = true})
            })

        end
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {
            signs = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '__' },
                topdelete    = { text = '‾‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({']c', bang = true})
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({'[c', bang = true})
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                map('n', '<leader>hr', gitsigns.reset_hunk)
                map('v', '<leader>hr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)
                map('n', '<leader>hb', gitsigns.reset_buffer)
                map('n', '<leader>hp', gitsigns.preview_hunk)
                map('n', '<leader>hi', gitsigns.preview_hunk_inline)
                map('n', '<leader>hd', gitsigns.diffthis)
                map('n', '<leader>ha', function() gitsigns.setqflist('all') end)
                map('n', '<leader>hq', gitsigns.setqflist)
                map({'o', 'x'}, 'ih', gitsigns.select_hunk)
            end
        }
    },
    -- {
    --     "kdheepak/lazygit.nvim",
    --     lazy = true,
    --     cmd = {
    --         "LazyGit",
    --         "LazyGitConfig",
    --         "LazyGitCurrentFile",
    --         "LazyGitFilter",
    --         "LazyGitFilterCurrentFile",
    --     },
    --     -- optional for floating window border decoration
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --     },
    --     -- setting the keybinding for LazyGit with 'keys' is recommended in
    --     -- order to load the plugin when the command is run for the first time
    --     keys = {
    --         { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    --     }
    -- }
}
