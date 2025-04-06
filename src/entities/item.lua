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
    -- Coordinates for the right edge of the shop container
    local containerRightX = 20 + 467  -- Adjust if your container changes

    local scale = 1
    local itemWidth = self.image:getWidth()
    local itemHeight = self.image:getHeight()

    -- Draw the item image (left side)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.image, x, y, 0, scale, scale)

    -- Draw the item name to the right of the image
    local nameOffset = 10    -- gap after the image
    local nameX = x + itemWidth + nameOffset
    local nameY = y
    
    local font = love.graphics.newFont(Constants.FONT_PATH, 16)
    love.graphics.setFont(font)
    love.graphics.print(self.name, nameX, nameY)

    -- Prepare cost/level text
    local costText = "$" .. self.cost
    local levelText = "Lvl: " .. self.levelRequirement

    -- Measure their text widths
    local costTextWidth = font:getWidth(costText)
    local levelTextWidth = font:getWidth(levelText)

    -- We'll place them on the same baseline as the item name
    local textY = y

    -- Right-align with a little padding from the container edge
    local rightPadding = 15
    local costX = containerRightX - rightPadding - costTextWidth

    -- We'll put the level requirement to the left of cost
    local gapBetween = 30
    local levelX = costX - gapBetween - levelTextWidth

    if self.purchased then
        ----------------------------------------------------------------
        -- ALREADY OWNED
        ----------------------------------------------------------------
        -- Replace cost text with "Owned"
        costText = "Owned"
        costTextWidth = font:getWidth(costText)
        costX = containerRightX - rightPadding - costTextWidth

        -- Draw the "Owned" text in green
        love.graphics.setColor(0, 1, 0)  -- Green
        love.graphics.print(costText, costX, textY)

        -- Level requirement is still displayed in normal color
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(levelText, levelX, textY)

    else
        ----------------------------------------------------------------
        -- NOT YET OWNED
        ----------------------------------------------------------------
        local canAfford = (money >= self.cost)
        local meetsLevel = (userLevel >= self.levelRequirement)

        -- If user can’t afford or doesn’t meet level, show cost in red
        if (not canAfford) or (not meetsLevel) then
            love.graphics.setColor(1, 0, 0) -- Red
        else
            love.graphics.setColor(1, 1, 1) -- White
        end
        love.graphics.print(costText, costX, textY)

        -- Draw level requirement in white
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(levelText, levelX, textY)

        -- If user level is too low, draw a lock overlay
        if not meetsLevel then
            -- Dark overlay on the item
            love.graphics.setColor(0, 0, 0, 0.7)
            love.graphics.rectangle("fill", x, y, itemWidth, itemHeight)

            -- Reset color to full white so the lock image isn’t tinted
            love.graphics.setColor(1, 1, 1, 1)

            -- Drawing lock
            local lockIcon = love.graphics.newImage("assets/images/shop/lock.png")
            -- Let's pick a scale factor (0.3 = 30% size)
            local scale = 0.2

            -- Compute the scaled width/height
            local lockScaledWidth = lockIcon:getWidth() * scale
            local lockScaledHeight = lockIcon:getHeight() * scale

            -- Center it on the item image
            local lockX = x + (itemWidth / 2) - (lockScaledWidth / 2)
            local lockY = y + (itemHeight / 2) - (lockScaledHeight / 2)

            -- Draw with the chosen scale
            love.graphics.draw(lockIcon, lockX, lockY, 0, scale, scale)
        end
    end

    -- Reset color
    love.graphics.setColor(1, 1, 1, 1)
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