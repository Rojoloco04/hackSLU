require("RGBConverter")
require("foundations/foundationGlobal")
require("./DisplayData/displayDataMain")

-- do not touch
taskbary = 0;

function buildTaskContainer()
    love.graphics.setColor(convertRGB(0, 36, 77))
    love.graphics.rectangle("fill", 20, 300, 467, 450, 15)
end

function buildTaskWindows()
    love.graphics.setColor(convertRGB(83, 195, 238))
    local basey = 310
    local gap = 10
    for i = 1, #taskList do
        love.graphics.rectangle("fill", 30, basey + (i - 1) * (78 + gap), 447, 78, 15)
        taskbary = basey + (i - 1) * (78 + gap)
    end
end

function drawMain()
    buildTaskContainer()
    buildTaskWindows()
    drawTaskButton()
    displayDataMain()
    
    currPage = "Main"
end