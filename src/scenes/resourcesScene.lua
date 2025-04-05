-- src/scenes/resourcesScene.lua
-- Resources scene implementation

local Constants = require("src.config.constants")
local Colors = require("src.config.colors")
local ColorUtils = require("src.utils.colorUtils")
local ResourceService = require("src.services.resourceService")

local ResourcesScene = {}

-- Initialize the scene
function ResourcesScene.initialize()
    -- Nothing specific to initialize for resources scene
end

-- Update the scene
function ResourcesScene.update(dt)
    -- Nothing to update continuously in this scene
end

-- Draw the resources container
function ResourcesScene.drawResourcesContainer()
    ColorUtils.setColor(unpack(Colors.PRIMARY_DARK))
    love.graphics.rectangle("fill", 0, 0, Constants.WINDOW_WIDTH, 755)
end

-- Draw the resources list
function ResourcesScene.drawResources()
    local resources = ResourceService.getAllResources()
    local font = love.graphics.newFont(Constants.FONT_PATH, 12)
    love.graphics.setFont(font)
    
    -- Set text color
    love.graphics.setColor(1, 1, 1)
    
    local baseY = 50
    local gap = -3.5
    local boxSize = 755 / #resources
    
    for i = 1, #resources do
        love.graphics.print(
            resources[i], 
            10, 
            baseY + (i - 1) * (boxSize + gap)
        )
    end
end

-- Draw the scene
function ResourcesScene.draw()
    ResourcesScene.drawResourcesContainer()
    ResourcesScene.drawResources()
end

-- Handle mouse press
function ResourcesScene.mousepressed(x, y, button, scale)
    -- No specific interactions for resources scene yet
    return false
end

-- Handle key press
function ResourcesScene.keypressed(key)
    -- No specific key handling for resources scene yet
    return false
end

return ResourcesScene