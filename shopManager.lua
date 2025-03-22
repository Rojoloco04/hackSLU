package.path = package.path .. ";./?.lua"
require("item")
require("data")

function purchase(item)
    local money = getMoney()
    if item.bought == true then
        print("Item has already been purchased")
    elseif money >= item.price then
        updateMoney("sub", item.price)
        item.bought = true
        print("Item " .. item.name .. " purchased for " .. item.price .. " Flex.")
    else
        print("Insufficient funds.")
    end
end

return shopManager