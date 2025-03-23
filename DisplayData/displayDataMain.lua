require("RGBConverter")

function displayDataMain()
    font = love.graphics.newFont("assets/Silkscreen-Regular.ttf", 30)
    love.graphics.setColor(0,0,0)
    local basey = 331
    local gap = 6
    print("Current taskList:")
for i, task in ipairs(taskList) do
    if type(task) == "table" then
        print("Task table detected. Name field:", task.name or "nil")
    else
        print("Unexpected type in taskList:", type(task))
    end
end
    for i, task in ipairs(taskList) do
        love.graphics.print(task.name, font, 40, basey + (i - 1) * (78 + gap))
    end
end
