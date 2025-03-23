package.path = package.path .. ";./?.lua"
require("item")
require("data")

function purchase(item)
    if not itemExists(item) then
        money = getMoney()
        level = getLevel()
        if money >= item.price and level >= item.lvlReq then
            updateMoney("sub", item.price)
            addItem(item)
            print("Item " .. item.name .. " purchased for " .. item.price .. " Flex.")
        else
            print("Insufficient funds.")
        end
    else
        print("Item already purchased")
    end
end

function pressItemList(x,y)
    local taskCenters = {}

    for i = 1, #items do
        local taskY = basey + (i - 1) * (78 + gap)
    

        local centerX = 30 + (447 / 2)  * scale_factor
        local centerY = taskY + (78 / 2) *scale_factor
        table.insert(taskCenters, {x = centerX, y = centerY})
    end
    local radius = 78 / 2 * scale_factor
    for i = 1, #taskCenters do
        local distanceM = distanceFromCircleButton(x, y, taskCenters[i].x, taskCenters[i].y, radius)
        local distanceL = distanceFromCircleButton(x, y, taskCenters[i].x-39, taskCenters[i].y, radius)
        local distanceR = distanceFromCircleButton(x, y, taskCenters[i].x+39, taskCenters[i].y, radius)
        local distanceLL = distanceFromCircleButton(x, y, taskCenters[i].x-39*2, taskCenters[i].y, radius)
        local distanceLLL = distanceFromCircleButton(x, y, taskCenters[i].x-39*3, taskCenters[i].y, radius)
        local distanceRR = distanceFromCircleButton(x, y, taskCenters[i].x+39*2, taskCenters[i].y, radius)
        local distanceRRR = distanceFromCircleButton(x, y, taskCenters[i].x+39*3, taskCenters[i].y, radius)
        local distanceRRRR = distanceFromCircleButton(x, y, taskCenters[i].x+39*4, taskCenters[i].y, radius)
        local distanceLLLL = distanceFromCircleButton(x, y, taskCenters[i].x-39*4, taskCenters[i].y, radius)
        -- I know this is god awful, but it works and im tired
        local distance = math.min(distanceM, distanceL, distanceR, distanceLL, distanceRR, distanceLLL, distanceRRR, distanceRRRR, distanceLLLL)


        if distance <= 78 / 2 then
            selectedItemIndex = i
            print("pressed task" .. i) 
        end
    end
end

function markItemonClick(x, y)
    pressItemList(x, y)

    if selectedItem then
        local curItem = items[selectedItemIndex]
        if curItem then
            purchase(item) 
        end
    end
end


function interactItemButton(x, y)
    local scaled_buttonX = buttonX * scale_factor
    local scaled_buttonY = buttonY * scale_factor
    local scaled_buttonRadius = buttonRadius * scale_factor

    local distance = distanceFromCircleButton(x, y, scaled_buttonX, scaled_buttonY, scaled_buttonRadius)

    if distance <= scaled_buttonRadius then
        if not addItemclicked then
            addItemclicked = true
            textboxD = textbox.create(textBoxX * scale_factor, textBoxY * scale_factor, 40 * scale_factor, 37 * scale_factor, "TASK")
            textboxD.selected = true
        end
    else
        if addItemclicked then
            for i = 1, 5 do
                local taskY = (textBoxY + (40 * i)) * scale_factor
                local taskHeight = textboxD.height * scale_factor
                local taskWidth = textboxD.width * scale_factor
                local taskX = textBoxX * scale_factor

                if x > taskX and x < taskX + taskWidth and y > taskY and y < taskY + taskHeight then
                    print("clicked " .. items[i])
                    textboxD:setText(items[i])
                    textboxD:createTask()
                    addTaskclicked = false
                    return -- Exit early after detecting a valid click
                end
            end

            addItemclicked = false -- Close menu only if no task was clicked
        end
    end
end


return shopManager