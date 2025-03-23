package.path = package.path .. ";./?.lua"
require("item")
require("data")

function purchase(item)
    if not itemExists(item.id) then  -- Ensure the item is not already purchased based on ID
        local money = getMoney()
        local level = getLevel()
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
    local itemCenters = {}

    for i = 1, 5 do
        local itemY = basey + (i - 1) * (78 + gap)
    

        local centerX = 30 + (447 / 2)  * scale_factor -20
        local centerY = itemY + (65 / 2) *scale_factor -20
        table.insert(itemCenters, {x = centerX, y = centerY})
    end
    local radius = 78 / 2 * scale_factor
    for i = 1, #itemCenters do
        local distanceM = distanceFromCircleButton(x, y, itemCenters[i].x, itemCenters[i].y, radius)
        local distanceL = distanceFromCircleButton(x, y, itemCenters[i].x-39, itemCenters[i].y, radius)
        local distanceR = distanceFromCircleButton(x, y, itemCenters[i].x+39, itemCenters[i].y, radius)
        local distanceLL = distanceFromCircleButton(x, y, itemCenters[i].x-39*2, itemCenters[i].y, radius)
        local distanceLLL = distanceFromCircleButton(x, y, itemCenters[i].x-39*3, itemCenters[i].y, radius)
        local distanceRR = distanceFromCircleButton(x, y, itemCenters[i].x+39*2, itemCenters[i].y, radius)
        local distanceRRR = distanceFromCircleButton(x, y, itemCenters[i].x+39*3, itemCenters[i].y, radius)
        local distanceRRRR = distanceFromCircleButton(x, y, itemCenters[i].x+39*4, itemCenters[i].y, radius)
        local distanceLLLL = distanceFromCircleButton(x, y, itemCenters[i].x-39*4, itemCenters[i].y, radius)
        -- I know this is god awful, but it works and im tired
        local distance = math.min(distanceM, distanceL, distanceR, distanceLL, distanceRR, distanceLLL, distanceRRR, distanceRRRR, distanceLLLL)


        if distance <= radius then
            selectedItemIndex = i
            print("pressed item " .. i)
            -- Call purchase here, but only once an item is selected.
            local curItem = items[currentPage * 5 + selectedItemIndex]
            if curItem then
                purchaseItem(curItem)
            end
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