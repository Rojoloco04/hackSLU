package.path = package.path .. ";./?.lua"
local json = require("libs/dkjson")

local itemDataFilename = "itemdata.json"

function readItemData()
    local file = io.open(itemDataFilename, "r")
    if not file then 
        return {}
    end

    local content = file:read("*a")
    file:close()
    local data = json.decode(content)
    if not data then
        return {}
    end
    return data
end

function writeItemData(data)
    local file = io.open(itemDataFilename, "w")
    if not file then 
        return false 
    end

    file:write(json.encode(data, { indent = true }))
    file:close()
    return true
end

function getAllItems()
    local items = readItemData()
    return items
end

function getItemByID(itemID)
    local items = readItemData()
    for _, item in ipairs(items) do
        if item.id == itemID then
            return item
        end
    end
    return nil
end

function itemExists(itemID)
    return getItemByID(itemID) ~= nil
end

function updateItem(itemID, newData)
    local items = readItemData()
    for i, item in ipairs(items) do
        if item.id == itemID then
            -- Update whatever fields you allow to be changed:
            if newData.name then
                item.name = newData.name
            end
            if newData.cost then
                item.cost = newData.cost
            end
            if newData.levelRequirement then
                item.levelRequirement = newData.levelRequirement
            end
            if newData.filepath then
                item.filepath = newData.filepath
            end
            writeItemData(items)
            return true
        end
    end
    return false
end

function loadItems()
    local data = readItemData()
    itemList = {}
    for _, item in item do
        local newTask = Task.new(task)
        table.insert(taskList, newTask)
    end
end

return {
    readItemData     = readItemData,
    writeItemData    = writeItemData,
    getAllItems      = getAllItems,
    getItemByID      = getItemByID,
    itemExists       = itemExists,
    updateItem       = updateItem,
    loadItems        = loadItems,
}
