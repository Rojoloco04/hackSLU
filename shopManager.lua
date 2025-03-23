package.path = package.path .. ";./?.lua"
require("item")
require("data")

function purchase(item)
    if not itemExists(item) then
        if money >= item.price then
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

return shopManager