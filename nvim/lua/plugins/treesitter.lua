return {
    'nvim-treesitter/nvim-treesitter',
    event = "BufReadPost",
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    dependencies = {
        -- { "nvim-treesitter/nvim-treesitter-textobjects" },
        {
            "windwp/nvim-ts-autotag", -- Autoclose and autorename HTML and Vue tags
            config = true,
        },
    },
    opts = {
        ensure_installed = {
            'go',
            'javascript',
            'typescript',
            'python',
            'bash',
            'c',
            'rust',
            'make',
            'gitignore',
            'tsx',
            'diff',
            'html',
            'lua',
            'luadoc',
            'markdown',
            'markdown_inline',
            'query',
            'vim',
            'vimdoc',
        },
        auto_install = true,
        highlight = {
            enable = true,
            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --  If you are experiencing weird indenting issues, add the language to
            --  the list of additional_vim_regex_highlighting and disabled languages for indent.
            -- additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = { enable = true, disable = { 'ruby' } },
    },
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
