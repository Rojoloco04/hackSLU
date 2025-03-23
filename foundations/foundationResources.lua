require("RGBConverter")
local resources = require("resources")


function buildResourceContainer()
    love.graphics.setColor(convertRGB(0, 36, 77))
    love.graphics.rectangle("fill", 0, 0, 507, 755)
end

function writeResources()
    font = love.graphics.newFont("assets/Silkscreen-Regular.ttf", 16)
    love.graphics.setColor(1,1,1)
    local basey = 50
    local gap = -3.5
    local boxSize = 755 / #resources
    for i=1,#resources do
        love.graphics.print(resources[i], font, 10, basey + (i - 1) * (boxSize + gap))
    end
end    

function drawResources()
    buildResourceContainer()
    writeResources()
end
