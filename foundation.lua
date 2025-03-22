-- do not touch
taskbary = 0;

function convertRGB(r,g,b)
    return r / 255, g / 255, b / 255
end

function buildTaskContainer()
    love.graphics.setColor(convertRGB(0, 36, 77))
    love.graphics.rectangle("fill", 20, 300, 467, 450, 15)
end

function buildTaskWindows()
    love.graphics.setColor(convertRGB(83, 195, 238))
    basey = 310
    gap = 10
    for i = 1, 5 do
        love.graphics.rectangle("fill", 30, basey + (i - 1) * (78 + gap), 447, 78, 15)
        taskbary = basey + (i - 1) * (78 + gap)
    end
end

function buildTaskBar()
    taskbary = taskbary - 10
    love.graphics.setColor(convertRGB(180,180,180))
    love.graphics.rectangle("fill", 0, taskbary + 108, 507, 900 - (taskbary + 88), 7)
end 