require("RGBConverter")

function buildButtons()
    love.graphics.setColor(0,0,0)
    local width = 507 / 4

    for i=1,4 do
        love.graphics.rectangle("line", 0 + ((i-1) * width), 755, width, 900 - (taskbary + 88), 7)
        
    end
end

function buttonText()
    local font = love.graphics.newFont(25)
    love.graphics.print("Home", font, 26, 785)
    love.graphics.print("Shop", font, 159, 785)
    love.graphics.print("Resource", font, 261.5, 785)
    love.graphics.print("Activity", font, 395, 785)
end


function buildGlobal() 
    love.graphics.setBackgroundColor(0.8,0.8,0.8)
    love.graphics.setColor(convertRGB(237, 139, 0))
    love.graphics.rectangle("fill", 0, 755, 507, 900 - (taskbary + 88), 7)
    buildButtons()
    buttonText()
end

