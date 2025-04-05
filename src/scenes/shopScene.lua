-- src/scenes/shopScene.lua
-- Shop scene implementation

local Constants = require("src.config.constants")
local ShopManager = require("src.managers.shopManager")
local AnimationManager = require("src.managers.animationManager")

local ShopScene = {}

-- Initialize the scene
function ShopScene.initialize()
    -- Initialize the shop manager if not already done
    if ShopManager.initialize then
        ShopManager.initialize()
    end
end

-- Update the scene
function ShopScene.update(dt)
    -- Nothing to update continuously in this scene
end

-- Draw the scene
function ShopScene.draw()
    -- Draw background
    love.graphics.setBackgroundColor(0.8, 0.8, 0.8)
    
    -- Draw background image
    local backgroundImage = love.graphics.newImage("assets/images/nonstore/background.png")
    love.graphics.draw(backgroundImage, 0, 0)
    
    -- Draw character in the center
    AnimationManager.draw((Constants.WINDOW_WIDTH / 2) - 100, 150)
    
    -- Draw shop interface
    ShopManager.draw()
end

-- Handle mouse press
function ShopScene.mousepressed(x, y, button, scale)
    -- Handle shop interactions
    return ShopManager.mousepressed(x, y, button, scale)
end

-- Handle key press
function ShopScene.keypressed(key)
    -- No specific key handling for shop scene yet
    return false
end

return ShopScene