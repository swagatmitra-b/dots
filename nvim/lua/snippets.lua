local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node

local function get_comment_string()
    return vim.api.nvim_eval("&commentstring"):gsub("%%s", "") or "# "
end

ls.add_snippets("all", {
    s("fixme", {
        f(function() return get_comment_string() end, {}),
        t("!FIXME!: "),
        i(1, ""),
    }),

    s("todo", {
        f(function() return get_comment_string() end, {}),
        t("TODO: "),
        i(1, ""),
    }),
})

