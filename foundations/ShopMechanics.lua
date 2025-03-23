function shopMechanics()
    local data = readUserData()
    local userLevel = data["level"]
    local money = data["money"]

    for i, image in ipairs(images) do

        -- Get item info from userdata
        local itemData = getItemByID(i)

        -- Check if item exists
        if itemData then
            -- Draw cost and level requirement if not purchased
            if not itemData.purchased then
                love.graphics.setColor(1, 0, 0) -- Red text for unpurchased
                love.graphics.print("Lvl: " .. itemData.levelReq, x, y + itemSize + 5)
                love.graphics.print("$" .. itemData.cost, x, y + itemSize + 25)

                -- Draw a lock icon if the level requirement is not met
                if userLevel < itemData.levelReq then
                    love.graphics.setColor(0, 0, 0, 0.7) -- Dim the image with a black overlay
                    love.graphics.rectangle("fill", x, y, itemSize, itemSize)
                    
                    -- Draw lock icon (simple rectangle as a placeholder)
                    love.graphics.setColor(1, 1, 0) -- Yellow for lock
                    love.graphics.rectangle("fill", x + itemSize / 2 - 10, y + itemSize / 2 - 10, 20, 20)
                end
            else
                -- Draw "Purchased" text on purchased items
                love.graphics.setColor(0, 1, 0)  -- Green text
                love.graphics.print("Owned", x, y + itemSize + 5)
            end
        end
    end
end
