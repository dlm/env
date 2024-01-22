local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- local f = ls.function_node
-- local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local ps = ls.parser.parse_snippet

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
	return args[1]
end

ls.add_snippets("all", {
	ps({
        trig = "trun",
        namr = "T.Run",
        dscr = "create a t.Run for go"
    }, [[
		t.Run("${1}", func(t *testing.T) {
			${0}
		})
	]]),

	ps({
        trig = "truntodo",
        namr = "T.Run TODO",
        dscr = "create a t.Run with a t.FailNow("
    }, [[
		t.Run(${0}, func(t *testing.T) {
		    assert.FailNow(t, "todo")
		})
	]]),

    s({
        trig = "bky-jira-link",
        namr = "Blocky Jira Link",
        dscr = "create a link to a blocky jira ticket the ticket number"
    }, {
        t("[bky-"),
        i(1, "ticket number"),
        t("](https://blocky.atlassian.net/browse/BKY-"),
        rep(1),
        t(")"),
    }),

    s({
        trig = "date-journal",
        namr = "Date Journal",
        dscr = "create the date for a journal entry",
    }, {
        i(1, os.date("%B %0e, %Y")),
    }
    ),
})

