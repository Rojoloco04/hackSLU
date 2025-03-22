package.path = package.path .. ";./?.lua"
local json = require("dkjson")
local filename = "userdata.json"

function readUserData()
    local file = io.open(filename, "r")
    if not file then return {} end
    local content = file:read("*a")
    file:close()
    return json.decode(content) or {}
end

function writeUserData(data)
    local file = io.open(filename, "w")
    if not file then return false end
    file:write(json.encode(data, { indent = true }))
    file:close()
    return true
end

-- money accessor
function getMoney()
    data = readUserData()
    return data["money"]
end

-- money mutator
function updateMoney(mode, amount)
    data = readUserData()

    money = data["money"]
    
    if mode == "sub" then
        money = money - amount
    elseif mode == "add" then
        money = money + amount
    else 
        print("*ERROR: Invalid mode. Use 'sub' or 'add'")
        return
    end

    data["money"] = money

    writeUserData(data)
end

-- xp accessor
function getXP()
    data = readUserData()
    return data["xp"]
end

-- xp mutator
function addXP(amount)
    data = readUserData()
    data["xp"] = data["xp"] + amount
    writeUserData(data)
end

-- level accessor
function getLevel()
    data = readUserData()
    return data["level"]
end

-- level mutators
function levelUp()
    data = readUserData()
    data["level"] = data["level"] + 1
    writeUserData(data)
end

function resetLevel()
    data = readUserData()
    data["level"] = 0
    writeUserData(data)
end

-- streak accessor
function getStreak()
    data = readUserData()
    return data["streak"]
end

-- streak mutators
function streakUp()
    data = readUserData()
    data["streak"] = data["streak"] + 1
    writeUserData(data)
end

function resetStreak()
    data = readUserData()
    data["streak"] = 0
    writeUserData(data)
end

-- name accessor
function getName()
    data = readUserData()
    return data["name"]
end

-- name mutator
function changeName(name)
    data = readUserData()
    data["name"] = name
    writeUserData(data)
end