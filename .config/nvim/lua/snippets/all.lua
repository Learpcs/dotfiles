local path = "/home/ivan/Projects/cf/fake/main.cpp"

local function readAll()
    local file = path
    local fl = assert(io.open(file, "rb"))
    local content = fl:read("*all")
    fl:close()
    return content
end



return {
    "For loop": {

    "prefix": "for",

    "description": "for (uint8 X = 0)",

    "body": ["for (${1:uint8_t} ${2:i} = 0; $2 < ${3}; $2++)", "{", "\t${0}", "}"]  
}
-- {
-- 	s("test1", { i(1), t"text to change", i(2), t"text again", i(3)}),
-- 	s("test2", { i(1), t"text to change", i(2), t"text again", i(3)}),
-- 	s("newsnip", { 
--       t's("',
--       i(1),
--       t'name", i(1), t"',
--       i(2),
--       t'code"})'
--    }),
--    s("readtest2", {
--       i(1), 
--       t[[readAll()
-- 123
--       ]]
--    })
-- }
