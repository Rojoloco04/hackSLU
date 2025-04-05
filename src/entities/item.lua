-- src/entities/item.lua
-- Item entity for shop items

local Constants = require("src.config.constants")
local DataService = require("src.services.dataService")
local json = require("libs.dkjson")

local Item = {}
Item.__index = Item

-- Create a new item
function Item.new(id, name, cost, levelRequirement, filepath)
    if not id or not name or not cost or not levelRequirement or not filepath then
        error("Missing required item parameters")
        return nil
    end
    
    local instance = {
        id = id,
        name = name,
        cost = cost,
        levelRequirement = levelRequirement,
        filepath = filepath,
        purchased = false,
        image = love.graphics.newImage(filepath)
    }
    
    return setmetatable(instance, Item)
end

-- Draw the item
function Item:draw(x, y, scale)
    scale = scale or 1
    
    -- Draw the item image
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.image, x, y, 0, scale, scale)
    
    -- Draw item name
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.name, x, y + self.image:getHeight() * scale + 5)
end

-- Draw item with price and level information
function Item:drawWithInfo(x, y, userLevel, money)
    -- Draw the base item
    self:draw(x, y)
    
    -- Draw additional information
    local font = love.graphics.newFont(Constants.FONT_PATH, 16)
    love.graphics.setFont(font)
    
    if not self.purchased then
        -- Draw cost
        love.graphics.setColor(1, 0, 0)  -- Red
        love.graphics.print("$" .. self.cost, x, y + self.image:getHeight() + 25)
        
        -- Draw level requirement
        love.graphics.print("Lvl: " .. self.levelRequirement, x, y + self.image:getHeight() + 5)
        
        -- If level requirement not met, draw a lock
        if userLevel < self.levelRequirement then
            love.graphics.setColor(0, 0, 0, 0.7)  -- Semi-transparent black
            love.graphics.rectangle("fill", x, y, self.image:getWidth(), self.image:getHeight())
            
            -- Draw lock icon
            love.graphics.setColor(1, 1, 0)  -- Yellow
            love.graphics.rectangle("fill", x + self.image:getWidth()/2 - 10, 
                                     y + self.image:getHeight()/2 - 10, 20, 20)
        end
    else
        -- Draw "Owned" text
        love.graphics.setColor(0, 1, 0)  -- Green
        love.graphics.print("Owned", x, y + self.image:getHeight() + 5)
    end
end

-- Check if item can be purchased
function Item:canPurchase(userLevel, money)
    if self.purchased then
        return false, "Already owned"
    end
    
    if userLevel < self.levelRequirement then
        return false, "Level too low"
    end
    
    if money < self.cost then
        return false, "Not enough money"
    end
    
    return true
end

-- Purchase the item
function Item:purchase(userLevel, money)
    local canBuy, reason = self:canPurchase(userLevel, money)
    
    if not canBuy then
        return false, reason
    end
    
    -- Mark as purchased and save to user data
    self.purchased = true
    
    -- Update user's money
    local data = DataService.readUserData()
    data.money = data.money - self.cost
    
    -- Add to purchased items
    local itemExists = false
    for i, item in ipairs(data.items or {}) do
        if item.id == self.id then
            data.items[i].purchased = true
            itemExists = true
            break
        end
    end
    
    if not itemExists and data.items then
        table.insert(data.items, {
            id = self.id,
            purchased = true
        })
    end
    
    return DataService.writeUserData(data)
end

-- Load item data from JSON file
function Item.loadItems()
    local file = io.open(Constants.ITEM_DATA_FILE, "r")
    if not file then
        error("Failed to open item data file")
        return {}
    end
    
    local content = file:read("*a")
    file:close()
    
    local itemData = json.decode(content) or {}
    local items = {}
    
    for _, data in ipairs(itemData) do
        local item = Item.new(
            data.id,
            data.name,
            data.cost,
            data.levelRequirement,
            data.filepath
        )
        
        -- Check if the item is already purchased
        local userData = DataService.readUserData()
        for _, userItem in ipairs(userData.items or {}) do
            if userItem.id == item.id and userItem.purchased then
                item.purchased = true
                break
            end
        end
        
        table.insert(items, item)
    end
    
    return items
end

-- Get an item by its ID
function Item.getById(items, id)
    for _, item in ipairs(items) do
        if item.id == id then
            return item
        end
    end
    
    return nil
end

return Item