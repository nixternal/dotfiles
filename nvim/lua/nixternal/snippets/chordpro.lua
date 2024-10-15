local ls = require('luasnip')
local s = ls.snippet
local f = ls.function_node

local function split_string(input, delimeter)
  local result = {}
  for part in input:gmatch("([^" .. delimeter .. "]+)") do
    table.insert(result, part)
  end
  return result
end

ls.add_snippets("chordpro", {
  s("filename_split", {
    f(function(_, snip)
      local filename = snip.env.TM_FILENAME_BASE
      local parts = split_string(filename, "--")
      local artist = parts[1]:gsub("_", " ")
      local song = parts[2]:gsub("_", " ")
      return artist .. " - " .. song
    end, {})
  })
})
