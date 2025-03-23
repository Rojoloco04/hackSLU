require("RGBConverter")
require("../foundation")
require("data")

function shopMechanics()
    loadShopImages("images/")
    local data = readUserData()
    local userLevel = data["level"]
    local money = data["money"]

    for i, image in ipairs(items) do  -- Changed images to items
        -- Get item info from userdata
        local itemData = itemExists(items[i])  -- Changed i to items[i]

        -- Check if item exists
        if itemData then
            -- Draw cost and level requirement if not purchased
            if not itemData.purchased then
                love.graphics.setColor(1, 0, 0) -- Red text for unpurchased
                love.graphics.print("Lvl: " .. itemData.levelReq, x, y + itemSize + 5)
                love.graphics.print("$" .. itemData.cost, x, y + itemSize + 25)

                -- Draw a lock icon if the level requirement is not met
                if userLevel < itemData.levelReq then
                    love.graphics.setColor(0, 0, 0, 0.7) -- Dim the image with a black overlay
                    love.graphics.rectangle("fill", x, y, itemSize, itemSize)
                    
                    -- Draw lock icon (simple rectangle as a placeholder)
                    love.graphics.setColor(1, 1, 0) -- Yellow for lock
                    love.graphics.rectangle("fill", x + itemSize / 2 - 10, y + itemSize / 2 - 10, 20, 20)
                end
            else
                -- Draw "Purchased" text on purchased items
                love.graphics.setColor(0, 1, 0)  -- Green text
                love.graphics.print("Owned", x, y + itemSize + 5)
            end
        end
    end
end


-- Load all .png images from the shop directory
local items = {}
local imagePath = "images/shop/"

function loadImagesFromDirectory(directory)
    for _, filename in ipairs(love.filesystem.getDirectoryItems(directory)) do
        if filename:match("%.png$") then
            local img = love.graphics.newImage(directory .. filename)
            table.insert(items, {image = img, name = filename})  -- Store image with filename for reference
        end
    end
end

-- Load images from the shop directory
loadImagesFromDirectory(imagePath)

local currentPage = 1

-- Build shop container
function buildShopContainer()
    love.graphics.setColor(convertRGB(0, 36, 77))
    love.graphics.rectangle("fill", 20, 300, 467, 450, 15)
end

-- Draw the entire shop
function drawShop()
    buildShopContainer()
    drawPageButtons()
    drawShopItems()
    shopMechanics()
    
    currPage = "Shop"
end

-- Draw items on the current page
function drawShopItems()
    local startX = 50
    local startY = 275
    local itemPerPage = 5
    local pageIndex = currentPage - 1

    for i = 1 + (pageIndex * itemPerPage), itemPerPage + (pageIndex * itemPerPage) do
        if items[i] then
            -- Draw the image
            love.graphics.draw(items[i].image, startX+45, startY+55)
            -- Draw the number (item name or index)
            local font = love.graphics.newFont("assets/Silkscreen-Regular.ttf", 24)
            love.graphics.setColor(1, 1, 1, 1)  -- White color for the text
            love.graphics.print(i, font, startX, startY + 50)  -- Display number below the image
        end
        startY = startY + 75
    end
end

-- Draw the page navigation buttons
function drawPageButtons()
    local startX = 75
    
    for i = 1, 8 do
        love.graphics.setColor(convertRGB(255, 255, 255))
        if i == currentPage then
            love.graphics.setColor(convertRGB(200, 201, 199))
        end
        love.graphics.circle("fill", startX, 725, 15, 100)
        local font = love.graphics.newFont("assets/Silkscreen-Regular.ttf", 20)
        love.graphics.setColor(convertRGB(0,0,0))
        love.graphics.print(i, font, startX - 6, 715)
        startX = startX + 50
    end
    love.graphics.setColor(convertRGB(255, 255, 255))
end

-- Interact with page buttons
function interactShopButton(x, y)
    for i = 1, 8 do 
        local startX = 75 * scale_factor
        local buttonY = 725 * scale_factor
        local buttonRadius = 15 * scale_factor
        local buttonX = startX + (i - 1) * (50 * scale_factor)

        local distance = distanceFromCircleButton(x, y, buttonX, buttonY, buttonRadius)

        if distance <= buttonRadius then
            print("clicked on " .. i)
            currentPage = i
        end
    end
end