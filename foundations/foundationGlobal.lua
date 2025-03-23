require("RGBConverter")

function buildGlobal()
    love.graphics.setBackgroundColor(0.9,0.9,0.9)
    love.graphics.setColor(convertRGB(180,180,180))
    love.graphics.rectangle("fill", 0, 755, 507, 900 - (taskbary + 88), 7)
end

