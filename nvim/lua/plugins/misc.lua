return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = '▏',
            },
            scope = {
                show_start = false,
                show_end = false,
                show_exact_scope = false,
            },
            exclude = {
                filetypes = {},
            },
        },
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({ })
        end
    },
    { 'echasnovski/mini.files',
        version = '*',
        config = function()
            local MiniFiles = require("mini.files")
            vim.keymap.set("n", "<leader>ne", "<CMD>lua MiniFiles.open()<CR>")
            MiniFiles.setup({})
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf = args.buf
                    vim.keymap.set("n", ".", function()
                        MiniFiles.trim_left()
                        MiniFiles.trim_right()
                    end, { buffer = buf, noremap = true, silent = true })
                end,
            })
        end,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { ";", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { ";;", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
}
