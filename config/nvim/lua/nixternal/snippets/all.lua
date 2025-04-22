local ls = require("luasnip")
local f = ls.function_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

local function split_string(input, delimeter)
	local result = {}
	for part in input:gmatch("([^" .. delimeter .. "]+)") do
		table.insert(result, part)
	end
	return result
end

ls.add_snippets(
	--[[ CHORDPRO SNIPPETS ]]
	--
	"chordpro",
	{
		s("skeleton", {
			t({ "{author: Rich Johnson}", "" }),
			t({ "{keywords: " }),
			i(1),
			t({ "}", "" }),
			f(function(_, snip)
				local filename = snip.env.TM_FILENAME_BASE
				local artist = split_string(filename, "--")[1]:gsub("_", " ")
				local title = split_string(filename, "--")[2]:gsub("_", " ")
				return {
					"{artist: " .. artist .. "}",
					"{title: " .. title .. "}",
				}
			end, {}),
			t({ "", "{key: " }),
			i(2),
			t({ "}", "" }),
			t({ "{capo: " }),
			i(3),
			t({ "}", "" }),
			t({ "{time: " }),
			i(4),
			t({ "}", "" }),
			t({ "{tempo: " }),
			i(5),
			t({ "}", "" }),
			t({ "{subtitle: ][  Key: %{key}  ][  Capo: %{capo}  ][  Time: %{time}  ][  Tempo: %{tempo}  ][}", "" }),
			i(0),
		}),
	}
)
