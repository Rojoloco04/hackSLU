require("RGBConverter")

function displayActivities()
    font = love.graphics.newFont("assets/Silkscreen-Regular.ttf", 30)
    love.graphics.setColor(0,0,0)
    love.graphics.print("Breathing Exercise", font, 65, 120)
    love.graphics.print("Walking", font, 175, 365)
    love.graphics.print("Journaling", font, 135, 590)
end