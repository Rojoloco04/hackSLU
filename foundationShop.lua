require("RGBConverter")
--we need multiple pages for skins
-- on press spawn a switch value of page id (needs to be implemented) and display a new container of skins
function buildShopContainer()
    love.graphics.setColor(convertRGB(0, 36, 77))
    love.graphics.rectangle("fill", 20, 300, 467, 450, 15)
end

function drawShop()
    buildShopContainer()

    currPage = "Shop"
end