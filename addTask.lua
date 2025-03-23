require("textbox")
require("task")
require("foundation")
api = {}
local tasks = require("defaultTasks")
local clicked = false
local textboxD = nil
local sizedifX, sizedifY = 14,120
local textBoxX, textBoxY = 27,300
local boxX = textBoxX - sizedifX
local boxY = 280
local buttonX, buttonY, buttonRadius = 465, 728, 30
function drawTaskButton(x,y)
    love.graphics.setColor(0,0,0,1)
    love.graphics.circle("fill", buttonX,buttonY,buttonRadius)
    
    if clicked then
        love.graphics.setColor(0,0,0,.7)
        love.graphics.rectangle("fill",0,0,1000,1000)
        love.graphics.setColor(convertRGB(143, 214, 189))
        love.graphics.rectangle("fill",boxX, boxY,textboxD.width+(2*sizedifX),textboxD.height+(2*sizedifY))
        local baseYDif = 40
        for i =1,5 do
            local font = love.graphics.newFont(15)
            love.graphics.setColor(1,1,1,.8)
            love.graphics.rectangle("fill",textBoxX, textBoxY+baseYDif,textboxD.width,textboxD.height)
            love.graphics.setColor(0,0,0,1)
            love.graphics.print(tasks[i],font, textBoxX, textBoxY+baseYDif)
            baseYDif = baseYDif + 40
        end
        textboxD:draw()
    end
end


function interactTaskButton(x, y)

    local distance = math.sqrt((x - buttonX)^2 + (y - buttonY)^2)

    if distance <= buttonRadius then
        if not clicked then
            clicked = true
             textboxD = textbox.create(27,300,40,50,"TASK")
            textboxD.selected = true
        end
    else
        if clicked then
            for i = 1,5 do
                if x > textBoxX and y > textBoxY + (40*i) and x < textBoxX + textboxD.width and y < textBoxY + (40*i) + textboxD.height then
                    print("clicked" .. tasks[i])
                    textboxD:setText(tasks[i])
                    textboxD:createTask()
                    clicked = false
                else
                    clicked = false
                end

            end
        end
    end

end
function typeTaskButton(key)
    if clicked then
        textboxD:keypressed(key)
        if key == 'return' then
            clicked = false
        end
    end
end
return api