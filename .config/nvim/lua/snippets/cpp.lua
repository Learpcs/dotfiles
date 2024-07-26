local function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

return
{
   s("readtest", {
      f(readAll("~/Projects/cf/fake/main.cpp"))
   })
}
