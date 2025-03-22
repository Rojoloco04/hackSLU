package.path = package.path .. ";./?.lua"
require("item")
require("readWrite")

function purchase(item)
    data = readUserData()

    for key, value in pairs(data) do
        if string.match(key, "money") then
            money = value
        end
    end

    if money > item.price then
        money = money - item.price
        print("Item " .. item.name .. " purchased for " .. item.price .. "Flex.")
    end

    for key, value in pairs(data) do
        if string.match(key, "money") then
            value = money
        end
    end

    writeUserData(data)
end 

