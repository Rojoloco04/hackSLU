require("DisplayData/displayActivities")

local activityAmount = 3 

function buildActivityContainer()
    love.graphics.setColor(convertRGB(0, 36, 77))
    love.graphics.rectangle("fill", 0, 0, 507, 755)
end

function writeActivities()
    love.graphics.setColor(convertRGB(83, 195, 238))
    local basey = 32
    local gap = 15
    for i=1,activityAmount do
        love.graphics.rectangle("fill", 10,  basey + (i - 1) * (220.6 + gap), 487, 225.66, 15)
    end
end

function drawActivity()
    buildActivityContainer()
    writeActivities()
    displayActivities()
end