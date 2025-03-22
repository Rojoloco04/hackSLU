local filename = "userdata.json"

-- Function to serialize a Lua table into a JSON-like string
local function serializeTable(tbl)
    local result = "{\n"
    for k, v in pairs(tbl) do
        local value = type(v) == "string" and "\"" .. v .. "\"" or v
        result = result .. string.format("  \"%s\": %s,\n", k, value)
    end
    result = result:sub(1, -3) .. "\n}"
    return result
end

-- Function to deserialize a JSON-like string into a Lua table
local function deserializeTable(str)
    local tbl = {}
    for k, v in string.gmatch(str, '"(.-)":%s*(%d+)') do
        tbl[k] = tonumber(v) or v
    end
    return tbl
end

-- Function to read user data from JSON file
local function readUserData()
    local file = io.open(filename, "r")
    if not file then return nil end
    local content = file:read("*a")
    file:close()
    return deserializeTable(content) or {}
end

-- Function to write user data to JSON file
local function writeUserData(data)
    local file = io.open(filename, "w")
    if not file then return false end
    file:write(serializeTable(data))
    file:close()
    return true
end

-- Example usage
local userData = readUserData() or {}

if not next(userData) then
    userData = { money = 1000, level = 1, xp = 0 }
    writeUserData(userData)
end

userData.money = userData.money + 500
userData.xp = userData.xp + 200
writeUserData(userData)

-- Print updated user data
for k, v in pairs(userData) do
    print(k .. ": " .. v)
end