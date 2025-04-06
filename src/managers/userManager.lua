-- src/managers/userManager.lua
-- Manages user-related data and operations

local Constants = require("src.config.constants")
local DataService = require("src.services.dataService")
local AnimationManager = require("src.managers.animationManager")

local UserManager = {}

-- Get current user money
function UserManager.getMoney()
    local data = DataService.readUserData()
    return data.money or 0
end

-- Update user money (add or subtract)
function UserManager.updateMoney(mode, amount)
    if type(amount) ~= "number" or amount < 0 then
        error("Invalid amount: must be a positive number")
        return false
    end

    local data = DataService.readUserData()
    
    if mode == "add" then
        data.money = data.money + amount
    elseif mode == "sub" then
        if data.money < amount then
            return false, "Insufficient funds"
        end
        data.money = data.money - amount
    else
        error("Invalid mode: must be 'add' or 'sub'")
        return false
    end
    
    return DataService.writeUserData(data)
end

-- Get current XP
function UserManager.getXP()
    local data = DataService.readUserData()
    return data.xp or 0
end

-- Add experience points and check for level up
function UserManager.addXP(amount)
    if type(amount) ~= "number" or amount < 0 then
        error("Invalid amount: must be a positive number")
        return false
    end

    local data = DataService.readUserData()
    data.xp = data.xp + amount
    -- Check if leveling up is needed
    UserManager.checkLevelUp(data)
    
    return DataService.writeUserData(data)
end

-- Set XP to a specific value
function UserManager.setXP(amount)
    if type(amount) ~= "number" or amount < 0 then
        error("Invalid amount: must be a positive number")
        return false
    end

    local data = DataService.readUserData()
    data.xp = amount
    
    return DataService.writeUserData(data)
end

-- Check and process level up if necessary
function UserManager.checkLevelUp(data)
    local didLevelUp = false
    
    while data.xp >= UserManager.getXPRequiredForNextLevel(data.level) do
        local xpRequired = UserManager.getXPRequiredForNextLevel(data.level)
        data.xp = data.xp - xpRequired
        data.level = data.level + 1
        didLevelUp = true
    end
    
    if didLevelUp and AnimationManager then
        AnimationManager.setAnimation("jump")
    end
    
    return didLevelUp
end

-- Calculate XP required for next level
function UserManager.getXPRequiredForNextLevel(level)
    return math.sqrt(level) * 100
end

-- Get current level
function UserManager.getLevel()
    local data = DataService.readUserData()
    return data.level or 1
end

-- Get current streak
function UserManager.getStreak()
    local data = DataService.readUserData()
    return data.streak or 0
end

-- Increment streak counter
function UserManager.incrementStreak()
    local data = DataService.readUserData()
    data.streak = data.streak + 1
    
    return DataService.writeUserData(data)
end

-- Reset streak counter
function UserManager.resetStreak()
    local data = DataService.readUserData()
    data.streak = 0
    
    return DataService.writeUserData(data)
end

-- Get user name
function UserManager.getName()
    local data = DataService.readUserData()
    return data.name or ""
end

-- Change user name
function UserManager.setName(name)
    if type(name) ~= "string" then
        error("Invalid name: must be a string")
        return false
    end
    
    local data = DataService.readUserData()
    data.name = name
    
    return DataService.writeUserData(data)
end

-- Draw player stats on screen
function UserManager.drawStats()
    local data = DataService.readUserData()
    local font = love.graphics.newFont(Constants.FONT_PATH, 16)
    
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(font)
    
    -- Display money
    love.graphics.print("Money: " .. data.money, 5, 15)
    
    -- Display XP with progress to next level
    local xpRequired = UserManager.getXPRequiredForNextLevel(data.level)
    love.graphics.print("XP: " .. math.floor(data.xp) .. " / " .. math.floor(xpRequired), 230, 15)
    
    -- Display level
    love.graphics.print("Level: " .. data.level, 400, 15)
    
    -- Display streak
    love.graphics.print("Streak: " .. data.streak, 125, 15)
end

return UserManager