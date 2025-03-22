local filename = "userdata.json"

-- Function to serialize a Lua table into a JSON-like string
function serializeTable(tbl)
    local result = "{\n"
    for k, v in pairs(tbl) do
        local value = type(v) == "string" and "\"" .. v .. "\"" or v
        result = result .. string.format("  \"%s\": %s,\n", k, value)
    end
    result = result:sub(1, -3) .. "\n}"
    return result
end

-- Function to deserialize a JSON-like string into a Lua table
function deserializeTable(str)
    local tbl = {}
    for k, v in string.gmatch(str, '"(.-)":%s*(%d+)') do
        tbl[k] = tonumber(v) or v
    end
    return tbl
end

-- Function to read user data from JSON file
function readUserData()
    local file = io.open(filename, "r")
    if not file then return nil end
    local content = file:read("*a")
    file:close()
    return deserializeTable(content) or {}
end

-- Function to write user data to JSON file
function writeUserData(data)
    local file = io.open(filename, "w")
    if not file then return false end
    file:write(serializeTable(data))
    file:close()
    return true
end

-- money accessor
function getMoney()
    data = readUserData()

    for key, value in pairs(data) do
        if string.match(key, "money") then
            money = value
        end
    end
    return money
end

-- money mutator
function updateMoney(mode, amount)
    data = readUserData()

    for key, value in pairs(data) do
        if string.match(key, "money") then
            money = value
        end
    end
    
    if mode == "sub" then
        money = money - amount
    elseif mode == "add" then
        money = money + amount
    else 
        print("*ERROR: Invalid mode. Use 'sub' or 'add'")
        return
    end

    for key, value in pairs(data) do
        if string.match(key, "money") then
            value = money
        end
    end

    writeUserData(data)
end

-- function to update user's xp amount

-- function to update user's level