-- src/scenes/activityScene.lua
-- Activity scene implementation

local Constants = require("src.config.constants")
local Colors = require("src.config.colors")
local ColorUtils = require("src.utils.colorUtils")

local ActivityScene = {
    activityAmount = 3,
    activityNames = {
        "Breathing Exercise",
        "Walking",
        "Journaling"
    }
}

-- Initialize the scene
function ActivityScene.initialize()
    -- Nothing specific to initialize for activity scene
end

-- Update the scene
function ActivityScene.update(dt)
    -- Nothing to update continuously in this scene
end

-- Draw the activity container
function ActivityScene.drawActivityContainer()
    ColorUtils.setColor(unpack(Colors.PRIMARY_DARK))
    love.graphics.rectangle("fill", 0, 0, Constants.WINDOW_WIDTH, 755)
end

-- Draw the activity boxes
function ActivityScene.drawActivityBoxes()
    ColorUtils.setColor(unpack(Colors.PRIMARY_LIGHT))
    
    local baseY = 32
    local gap = 15
    local boxHeight = 225.66
    
    for i = 1, ActivityScene.activityAmount do
        love.graphics.rectangle(
            "fill", 
            10, 
            baseY + (i - 1) * (boxHeight + gap), 
            487, 
            boxHeight, 
            15
        )
    end
end

-- Draw activity names
function ActivityScene.drawActivityNames()
    local font = love.graphics.newFont(Constants.FONT_PATH, 30)
    love.graphics.setFont(font)
    love.graphics.setColor(0, 0, 0)
    
    -- Position for each activity name
    local positions = {
        {x = 65, y = 120},   -- Breathing Exercise
        {x = 175, y = 365},  -- Walking
        {x = 135, y = 590}   -- Journaling
    }
    
    for i, activity in ipairs(ActivityScene.activityNames) do
        love.graphics.print(
            activity, 
            positions[i].x, 
            positions[i].y
        )
    end
end

-- Draw the scene
function ActivityScene.draw()
    ActivityScene.drawActivityContainer()
    ActivityScene.drawActivityBoxes()
    ActivityScene.drawActivityNames()
end

-- Handle mouse press
function ActivityScene.mousepressed(x, y, button, scale)
    -- Activity selection logic would go here
    -- For now, just log which activity was clicked
    
    local baseY = 32
    local gap = 15
    local boxHeight = 225.66
    
    for i = 1, ActivityScene.activityAmount do
        local activityY = (baseY + (i - 1) * (boxHeight + gap)) * scale
        
        if y >= activityY and y <= activityY + (boxHeight * scale) and
           x >= 10 * scale and x <= 497 * scale then
            print("Selected activity: " .. ActivityScene.activityNames[i])
            return true
        end
    end
    
    return false
end

-- Handle key press
function ActivityScene.keypressed(key)
    -- No specific key handling for activity scene yet
    return false
end

return ActivityScene