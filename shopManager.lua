package.path = package.path .. ";./?.lua"
require("item")
require("data")

function purchase(item)
    local money = getMoney()
    -- check if item already purchased
    if money >= item.price  then
        updateMoney("sub", item.price)
        addItem(item)
        print("Item " .. item.name .. " purchased for " .. item.price .. " Flex.")
    else
        print("Insufficient funds.")
    end
end

return shopManager