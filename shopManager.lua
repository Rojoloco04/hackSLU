package.path = package.path .. ";./?.lua"
require("item")
require("data")

function purchase(item)
    local money = getMoney()
    if money >= item.price then
        updateMoney("sub", item.price)
        print("Item " .. item.name .. " purchased for " .. item.price .. " Flex.")
    else
        print("Insufficient funds.")
    end
end

return shopManager