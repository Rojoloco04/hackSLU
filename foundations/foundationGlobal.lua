require("RGBConverter")
local currentGlobalPage = 1
local taskbary = 662
function buildButtons()
    love.graphics.setColor(0,0,0)
    local width = 507 / 4

    for i=1,4 do
        love.graphics.rectangle("line", 0 + ((i-1) * width), 755, width, 900 - (taskbary + 88), 7)
        
    end
end

function buttonText()
    local font = love.graphics.newFont("assets/Silkscreen-Regular.ttf",16)
    love.graphics.print("Home", font, 26, 785)
    love.graphics.print("Shop", font, 159, 785)
    love.graphics.print("Resources", font, 261.5, 785)
    love.graphics.print("Activity", font, 395, 785)
end


function buildGlobal() 
    love.graphics.setBackgroundColor(0.8,0.8,0.8)
    love.graphics.setColor(convertRGB(237, 139, 0))
    local width = 507 / 4
    for i=1,4 do
        love.graphics.setColor(convertRGB(237, 139, 0))
        if i == currentGlobalPage then
            love.graphics.setColor(convertRGB(190, 110, 0))
        end
        love.graphics.rectangle("fill", 0 + ((i-1) * width), 755, width, 900 - (taskbary + 88), 7)
    end
    
    buildButtons()
    buttonText()
end


function globalPress(x, y)
    local width = (507 / 4) * scale_factor
    local height = (900 - (taskbary + 88)) * scale_factor
    local startY = 755 * scale_factor

    local centers = {}

    for i = 1, 4 do
        local centerX = ((i - 1) * width) + (width / 2)
        local centerY = startY + (height / 2)
        table.insert(centers, {x = centerX, y = centerY})
    end
    for i=1,4 do
        local distance = distanceFromCircleButton(x, y, centers[i].x, centers[i].y, width / 2)
        if distance <= width / 2 then
            currentGlobalPage = i
            if i == 1 then
                currPage = "Main"
            elseif i == 2 then
                currPage = "Shop"
            elseif i == 3 then
                currPage = "Resources"
            elseif i == 4 then
                currPage = "Activities"
            end
        end
    end
end