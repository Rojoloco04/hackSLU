require("RGBConverter")
require("foundations/foundationGlobal")
require("DisplayData/displayDataMain")

-- do not touch
local taskbary = 0;

function buildTaskContainer()
    love.graphics.setColor(convertRGB(0, 36, 77))
    love.graphics.rectangle("fill", 20, 300, 467, 450, 15)
end

function buildTaskWindows()
    love.graphics.setColor(convertRGB(83, 195, 238))
    local basey = 310
    local gap = 10
    for i=1,#taskList do
        love.graphics.rectangle("fill", 30, basey + (i - 1) * (78 + gap), 447, 78, 15)
        taskbary = basey + (i - 1) * (78 + gap)
    end
end

function drawMain()
    
    buildTaskContainer()
    buildTaskWindows()
    displayDataMain()
    drawTaskButton()
    
    
    currPage = "Main"
end

function pressTasksList(x,y)
    local taskCenters = {}

    for i = 1, #taskList do
        local taskY = basey + (i - 1) * (78 + gap)
        love.graphics.rectangle("fill", 30, taskY, 447, 78, 15)
    

        local centerX = 30 + (447 / 2)  
        local centerY = taskY + (78 / 2) 
        table.insert(taskCenters, {x = centerX, y = centerY})
    end
    
    for i = 1, #taskCenters do
        local distanceM = distanceFromCircleButton(x, y, taskCenters[i].x, taskCenters[i].y, 78 / 2)
        local distanceL = distanceFromCircleButton(x, y, taskCenters[i].x-39, taskCenters[i].y, 78 / 2)
        local distanceR = distanceFromCircleButton(x, y, taskCenters[i].x+39, taskCenters[i].y, 78 / 2)
        local distanceLL = distanceFromCircleButton(x, y, taskCenters[i].x-39*2, taskCenters[i].y, 78 / 2)
        local distanceLLL = distanceFromCircleButton(x, y, taskCenters[i].x-39*3, taskCenters[i].y, 78 / 2)
        local distanceRR = distanceFromCircleButton(x, y, taskCenters[i].x+39*2, taskCenters[i].y, 78 / 2)
        local distanceRRR = distanceFromCircleButton(x, y, taskCenters[i].x+39*3, taskCenters[i].y, 78 / 2)
        local distanceRRRR = distanceFromCircleButton(x, y, taskCenters[i].x+39*4, taskCenters[i].y, 78 / 2)
        local distanceLLLL = distanceFromCircleButton(x, y, taskCenters[i].x-39*4, taskCenters[i].y, 78 / 2)
        -- I know this is god awful, but it works and im tired
        local distance = math.min(distanceM, distanceL, distanceR, distanceLL, distanceRR, distanceLLL, distanceRRR, distanceRRRR, distanceLLLL)


        if distance <= 78 / 2 then
            selectedTaskIndex = i
            print("pressed task" .. i)  -- Assuming you have taskList holding task names or objects
        end
    end
end