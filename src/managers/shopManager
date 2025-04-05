-- src/managers/shopManager.lua
-- Manages shop operations and item purchasing

local Constants = require("src.config.constants")
local Colors = require("src.config.colors")
local ColorUtils = require("src.utils.colorUtils")
local MathUtils = require("src.utils.mathUtils")
local Item = require("src.entities.item")
local UserManager = require("src.managers.userManager")
local DataService = require("src.services.dataService")

local ShopManager = {
    items = {},
    currentPage = 1,
    itemsPerPage = 5,
    totalPages = 1,
    
    -- Page button coordinates
    pageButtonStartX = 75,
    pageButtonY = 725,
    pageButtonRadius = 15,
    pageButtonGap = 50,
    
    -- Item display coordinates
    itemStartX = 50,
    itemStartY = 275,
    itemGap = 75
}

-- Initialize the shop manager
function ShopManager.initialize()
    -- Load all items
    ShopManager.items = Item.loadItems()
    
    -- Calculate total pages
    ShopManager.totalPages = math.ceil(#ShopManager.items / ShopManager.itemsPerPage)
    
    -- Ensure current page is valid
    if ShopManager.currentPage > ShopManager.totalPages then
        ShopManager.currentPage = 1
    end
end

-- Draw the shop container
function ShopManager.drawContainer()
    -- Draw container background
    ColorUtils.setColor(unpack(Colors.PRIMARY_DARK))
    love.graphics.rectangle(
        "fill", 
        20, 
        300, 
        467, 
        450, 
        15
    )
end

-- Draw page navigation buttons
function ShopManager.drawPageButtons()
    local startX = ShopManager.pageButtonStartX
    
    for i = 1, ShopManager.totalPages do
        -- Draw button background (highlight current page)
        if i == ShopManager.currentPage then
            love.graphics.setColor(0.8, 0.8, 0.8) -- Highlighted color
        else
            love.graphics.setColor(1, 1, 1) -- Normal color
        end
        
        love.graphics.circle("fill", startX, ShopManager.pageButtonY, ShopManager.pageButtonRadius, 100)
        
        -- Draw page number
        local font = love.graphics.newFont(Constants.FONT_PATH, 20)
        love.graphics.setFont(font)
        love.graphics.setColor(0, 0, 0)
        
        -- Center the text
        local textWidth = font:getWidth(tostring(i))
        local textHeight = font:getHeight()
        love.graphics.print(
            tostring(i), 
            startX - textWidth/2, 
            ShopManager.pageButtonY - textHeight/2
        )
        
        -- Move to next button position
        startX = startX + ShopManager.pageButtonGap
    end
    
    -- Reset color
    love.graphics.setColor(1, 1, 1)
end

-- Draw items for the current page
function ShopManager.drawItems()
    local startX = ShopManager.itemStartX
    local startY = ShopManager.itemStartY
    local pageIndex = ShopManager.currentPage - 1
    local itemsPerPage = ShopManager.itemsPerPage
    
    -- Get user level and money for item availability
    local userLevel = UserManager.getLevel()
    local money = UserManager.getMoney()
    
    for i = 1 + (pageIndex * itemsPerPage), math.min(itemsPerPage + (pageIndex * itemsPerPage), #ShopManager.items) do
        local item = ShopManager.items[i]
        
        if item then
            -- Draw the item with its info
            item:drawWithInfo(startX + 45, startY + 55, userLevel, money)
            
            -- Draw item number
            local font = love.graphics.newFont(Constants.FONT_PATH, 24)
            love.graphics.setColor(1, 1, 1)
            love.graphics.setFont(font)
            love.graphics.print(i, startX, startY + 50)
            
            -- Move to next item position
            startY = startY + ShopManager.itemGap
        end
    end
end

-- Draw the entire shop interface
function ShopManager.draw()
    ShopManager.drawContainer()
    ShopManager.drawPageButtons()
    ShopManager.drawItems()
end

-- Handle page button clicks
function ShopManager.handlePageButtonClick(x, y, scale)
    scale = scale or 1
    
    for i = 1, ShopManager.totalPages do
        local buttonX = (ShopManager.pageButtonStartX + (i - 1) * ShopManager.pageButtonGap) * scale
        local buttonY = ShopManager.pageButtonY * scale
        local buttonRadius = ShopManager.pageButtonRadius * scale
        
        local distance = MathUtils.distanceFromCircle(
            x, y, buttonX, buttonY, buttonRadius
        )
        
        if distance <= buttonRadius then
            ShopManager.currentPage = i
            return true
        end
    end
    
    return false
end

-- Handle item clicks
function ShopManager.handleItemClick(x, y, scale)
    scale = scale or 1
    
    local startX = ShopManager.itemStartX * scale
    local startY = ShopManager.itemStartY * scale
    local itemHeight = ShopManager.itemGap * scale
    local itemWidth = 447 * scale
    
    local pageIndex = ShopManager.currentPage - 1
    local itemsPerPage = ShopManager.itemsPerPage
    
    for i = 1, itemsPerPage do
        local itemIndex = i + (pageIndex * itemsPerPage)
        
        if itemIndex <= #ShopManager.items then
            local itemY = startY + ((i - 1) * itemHeight)
            
            if x >= startX and x <= startX + itemWidth and
               y >= itemY and y <= itemY + itemHeight then
                
                -- Try to purchase the item
                local item = ShopManager.items[itemIndex]
                local userLevel = UserManager.getLevel()
                local money = UserManager.getMoney()
                
                if item:canPurchase(userLevel, money) then
                    item:purchase(userLevel, money)
                    return true
                end
                
                return true -- Item was clicked but couldn't be purchased
            end
        end
    end
    
    return false
end

-- Handle mouse press
function ShopManager.mousepressed(x, y, button, scale)
    scale = scale or 1
    
    -- Check button clicks in order of priority
    return ShopManager.handlePageButtonClick(x, y, scale) or
           ShopManager.handleItemClick(x, y, scale)
end

return ShopManager