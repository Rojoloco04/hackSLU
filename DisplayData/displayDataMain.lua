require("RGBConverter")

function displayDataMain()
    font = love.graphics.newFont("assets/Silkscreen-Regular.ttf", 30)
    love.graphics.setColor(0,0,0)
    local basey = 331
    local gap = 6
    for i, task in ipairs(taskList) do
        love.graphics.print(task, font, 40, basey + (i - 1) * (78 + gap))
    end
end
