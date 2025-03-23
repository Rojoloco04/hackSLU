require("RGBConverter")
require("../foundation")
--local items = *get items here*
local items = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40}
local currentPage = 1
--we need multiple pages for skins
-- on press spawn a switch value of page id (needs to be implemented) and display a new container of skins
function buildShopContainer()
    love.graphics.setColor(convertRGB(0, 36, 77))
    love.graphics.rectangle("fill", 20, 300, 467, 450, 15)
end

function drawShop()
    buildShopContainer()
    drawPageButtons()
    drawShopItems()

    currPage = "Shop"
end

function drawShopItems()
    local startX = 50
    local startY = 350
    local itemPerPage = 5
    local pageIndex = currentPage - 1

    for i = 1+(pageIndex*itemPerPage), itemPerPage+(pageIndex*itemPerPage) do
        [[
        where items are drawn
        MAKE SURE THAT ITEMS ARE A MULTIPLE OF 5 OR IT WONT WORK :D
        local font = love.graphics.newFont(25)
        love.graphics.setColor(1,1,1,1)
        love.graphics.print(items[i],font,startX,startY)
        startY = startY + 75
        ]]
    end
end

function drawPageButtons()
    local startX = 75
    
    for i =1,8 do
        love.graphics.setColor(convertRGB(255, 255, 255))
        if i == currentPage then
            love.graphics.setColor(convertRGB(200, 201, 199))
        end
        love.graphics.circle("fill", startX, 725, 15, 100)
        font = love.graphics.newFont(20)
        love.graphics.setColor(convertRGB(0,0,0))
        love.graphics.print(i,font,startX-6,715)
        startX = startX + 50
    end
    love.graphics.setColor(convertRGB(255, 255, 255))
end

function interactShopButton(x,y)
    for i = 1,8 do 
        local startX = 75
        local distance = distanceFromCircleButton(x, y, startX + (i-1)*50,725,15)
        if distance <= 15 then
            print("clicked on " .. i)
            currentPage = i
        end
    end
end
        
