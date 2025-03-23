require("textbox")
require("task")
require("foundation")
api = {}
local tasks = require("defaultTasks")
addTaskclicked = false
local textboxD = nil
local sizedifX, sizedifY = 14,120
local textBoxX, textBoxY = 27,300
local boxX = textBoxX - sizedifX
local boxY = 280
local buttonX, buttonY, buttonRadius = 465, 728, 30

function drawPlus(x, y)
    love.graphics.setColor(0, 0, 0)

    -- Draw the even larger vertical line of the cross
    love.graphics.rectangle("fill", x - 2, y - 15, 5, 30)  -- Even larger vertical rectangle

    -- Draw the even larger horizontal line of the cross
    love.graphics.rectangle("fill", x - 15, y - 3, 30, 5)  -- Even larger horizontal rectangle
    love.graphics.setColor(1, 1, 1)
end



function drawTaskButton(x,y)
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill", buttonX,buttonY,buttonRadius)
    drawPlus(buttonX, buttonY)
    
    if addTaskclicked then
        love.graphics.setColor(0,0,0,.7)
        love.graphics.rectangle("fill",0,0,1000,1000)
        love.graphics.setColor(convertRGB(143, 214, 189))
        love.graphics.rectangle("fill",boxX, boxY,textboxD.width+(2*sizedifX),textboxD.height+(2*sizedifY),15)
        local baseYDif = 40
        for i =1,5 do
            local font = love.graphics.newFont("assets/Silkscreen-Regular.ttf", 16)
            love.graphics.setColor(1,1,1,.8)
            love.graphics.rectangle("fill",textBoxX, textBoxY+baseYDif,textboxD.width,textboxD.height,15)
            love.graphics.setColor(0,0,0,1)
            love.graphics.print(tasks[i],font, textBoxX+7, textBoxY+baseYDif)
            baseYDif = baseYDif + 40
        end
        textboxD:draw()
    end
end


function interactTaskButton(x, y)
    local scaled_buttonX = buttonX * scale_factor
    local scaled_buttonY = buttonY * scale_factor
    local scaled_buttonRadius = buttonRadius * scale_factor

    local distance = distanceFromCircleButton(x, y, scaled_buttonX, scaled_buttonY, scaled_buttonRadius)

    if distance <= scaled_buttonRadius then
        if not addTaskclicked then
            addTaskclicked = true
            textboxD = textbox.create(textBoxX * scale_factor, textBoxY * scale_factor, 40 * scale_factor, 37 * scale_factor, "TASK")
            textboxD.selected = true
        end
    else
        if addTaskclicked then
            for i = 1, 5 do
                local taskY = (textBoxY + (40 * i)) * scale_factor
                local taskHeight = textboxD.height * scale_factor
                local taskWidth = textboxD.width * scale_factor
                local taskX = textBoxX * scale_factor

                if x > taskX and x < taskX + taskWidth and y > taskY and y < taskY + taskHeight then
                    print("clicked " .. tasks[i])
                    textboxD:setText(tasks[i])
                    textboxD:createTask()
                    addTaskclicked = false
                    return -- Exit early after detecting a valid click
                end
            end

            addTaskclicked = false -- Close menu only if no task was clicked
        end
    end
end

function typeTaskButton(key)
    if addTaskclicked then
        textboxD:keypressed(key)
        if key == 'return' then
            addTaskclicked = false
        end
    end
end
return api