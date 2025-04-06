-- src/services/dataService.lua
-- Handles data persistence and management

local Constants = require("src.config.constants")
local json = require("libs.dkjson")

local DataService = {}

-- Read user data from JSON file
function DataService.readUserData()
    local file = io.open(Constants.USER_DATA_FILE, "r")
    if not file then 
        return {} 
    end
    
    local content = file:read("*a")
    file:close()
    
    local data = json.decode(content)
    return data or {}
end

-- Write user data to JSON file
function DataService.writeUserData(data)
    local file = io.open(Constants.USER_DATA_FILE, "w")
    if not file then
        error("Failed to open user data file for writing")
        return false
    end
    
    file:write(json.encode(data, { indent = true }))
    file:close()

    -- Immediately re-open for a quick read to confirm the data
    local confirmFile = io.open(Constants.USER_DATA_FILE, "r")
    local content = confirmFile:read("*a") or ""
    confirmFile:close()

    print("DEBUG: File after write:\n" .. content)

    return true
end

-- Initialize user data with default values if not present
function DataService.initializeUserData()
    local data = DataService.readUserData()
    
    -- Set default values if not present
    data.money = data.money or 0
    data.xp = data.xp or 0
    data.level = data.level or 1
    data.streak = data.streak or 0
    data.name = data.name or ""
    data.items = data.items or {}
    data.tasks = data.tasks or {}
    data.dueDate = data.dueDate or {}
    
    return DataService.writeUserData(data)
end

-- Get current date in a standardized format
function DataService.getCurrentDate()
    local curDate = os.date("!*t")
    local date = {
        year = curDate.year,
        month = curDate.month,
        day = curDate.day,
        hour = curDate.hour + Constants.TIMEZONE_OFFSET,
        minute = curDate.min
    }
    
    -- Handle day change when adjusting timezone
    if date.hour < 0 then
        date.hour = date.hour + 24
        date.day = date.day - 1
    end
    
    return date
end

-- Store tomorrow's date as the due date
function DataService.storeDueDate()
    local data = DataService.readUserData()
    local currentDate = DataService.getCurrentDate()
    
    -- Set due date to next day at midnight
    local dueDate = {
        year = currentDate.year,
        month = currentDate.month,
        day = currentDate.day + 1,
        hour = 0,
        minute = 0
    }
    
    data.dueDate = dueDate
    return DataService.writeUserData(data)
end

-- Check for end of day and update streak
function DataService.processEndOfDay()
    local data = DataService.readUserData()
    local currentDate = DataService.getCurrentDate()
    
    -- Skip if no due date is set
    if not data.dueDate or not data.dueDate.year then
        DataService.storeDueDate()
        return false
    end
    
    -- Format dates as YYYYMMDD integers for comparison
    local dueDate = data.dueDate
    local dueDateNum = dueDate.year * 10000 + dueDate.month * 100 + dueDate.day
    local currentDateNum = currentDate.year * 10000 + currentDate.month * 100 + currentDate.day
    
    -- Check if current date is past the due date
    if currentDateNum > dueDateNum then
        if #data.tasks > 0 then
            -- Tasks remain - streak broken
            data.streak = 0
            print("Streak broken!")
        else
            -- All tasks complete - streak maintained
            data.streak = data.streak + 1
            print("Streak maintained!")
        end
        
        DataService.writeUserData(data)
        DataService.storeDueDate()
        return true
    end
    
    return false
end

return DataService