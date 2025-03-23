require("RGBConverter")
require("DisplayData/displayResources")


function buildResourceContainer()
    love.graphics.setColor(convertRGB(0, 36, 77))
    love.graphics.rectangle("fill", 0, 0, 507, 755)
end   

function drawResources()
    buildResourceContainer()
    writeResources()
end
