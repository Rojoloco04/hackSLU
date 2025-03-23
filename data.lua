package.path = package.path .. ";./?.lua"
local json = require("libs/dkjson")
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

-- data constructor
function startUp()
    local data = readUserData()
    data["money"] = data["money"] or 0
    data["xp"] = data["xp"] or 0
    data["level"] = data["level"] or 1
    data["streak"] = data["streak"] or 0
    data["name"] = data["name"] or ""
    data["items"] = data["items"] or {}
    data["tasks"] = data["tasks"] or {}
    writeUserData(data)
end

-- money accessor
function getMoney()
    local data = readUserData()
    return data["money"]
end

-- money mutator
function updateMoney(mode, amount)
    local data = readUserData()

    local money = data["money"]
    
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
    local data = readUserData()
    return data["xp"]
end

-- xp mutator
function addXP(amount)
    local data = readUserData()
    data["xp"] = data["xp"] + amount
    writeUserData(data)
end

-- level accessor
function getLevel()
    local data = readUserData()
    return data["level"]
end

-- level mutators
function levelUp()
    local data = readUserData()
    data["level"] = data["level"] + 1
    writeUserData(data)
end

function resetLevel()
    local data = readUserData()
    data["level"] = 0
    writeUserData(data)
end

-- streak accessor
function getStreak()
    local data = readUserData()
    return data["streak"]
end

-- streak mutators
function streakUp()
    local data = readUserData()
    data["streak"] = data["streak"] + 1
    writeUserData(data)
end

function resetStreak()
    local data = readUserData()
    data["streak"] = 0
    writeUserData(data)
end

-- name accessor
function getName()
    local data = readUserData()
    return data["name"]
end

-- name mutator
function changeName(name)
    local data = readUserData()
    data["name"] = name
    writeUserData(data)
end

-- item tracking
function addItem(item)
    local data = readUserData()
    if not itemExists(item) then
        table.insert(data["items"], item.id)
    end
    writeUserData(data)
end

function itemExists(item)
    local data = readUserData()
    for _, existingID in ipairs(data["items"]) do
        if existingID == item.id then
            return true
        end
    end
    return false
end

-- task tracking
function addActiveTask(task)
    local data = readUserData()
    if not activeTaskExists(task) then
        table.insert(data["tasks"], task.name)
        print("Task " .. task.name .. " has been added to active tasks.")
    end
    writeUserData(data)
end

function activeTaskExists(task)
    local data = readUserData()
    for _, existingTask in ipairs(data["tasks"]) do
        if existingTask == task.name then
            return true
        end
    end
    return false
end

-- load tasks from json
function loadTasks()
    local data = readUserData()
    for _, task in ipairs(data["tasks"]) do
        table.insert(taskList, task)
    end
end

return data