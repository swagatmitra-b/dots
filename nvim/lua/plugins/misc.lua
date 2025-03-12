return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({ })
        end
    },
    { 'echasnovski/mini.files',
        version = false,
        config = function()
            local MiniFiles = require("mini.files")
            vim.keymap.set("n", "<leader>ne", "<CMD>lua MiniFiles.open()<CR>")
            MiniFiles.setup({})
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf = args.buf
                    local opts = { buffer = buf, noremap = true, silent = true }
                    vim.keymap.set("n", ".", "", opts)
                    vim.keymap.set("n", ".", function()
                        MiniFiles.trim_left()
                        MiniFiles.trim_right()
                    end, opts)
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
    {
        "swagatmitra-b/cepheid.nvim",
        config = function ()
            require("todo").setup({})
        end
    }
}
