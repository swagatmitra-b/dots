return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                color_overrides = {
                    mocha = {
                        base   = "#12121C",
                        mantle = "#0E0E17",
                        core   = "#09090F",
                    }
                },
            })
        end
    },
}
