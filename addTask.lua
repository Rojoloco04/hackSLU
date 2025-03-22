require("textbox")
require("task")

api = {}
local clicked = false
local textboxD = nil
local sizedifX, sizedifY = 14,200
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
        love.graphics.setColor(200/255,200/255,200/255,1)
        love.graphics.rectangle("fill",boxX, boxY,textboxD.width+(2*sizedifX),textboxD.height+(2*sizedifY))
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
        else
            clicked = false
        end
    else
        clicked = false
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