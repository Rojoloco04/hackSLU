-- src/scenes/mainScene.lua
-- Main scene implementation

local Constants = require("src.config.constants")
local Colors = require("src.config.colors")
local ColorUtils = require("src.utils.colorUtils")
local TaskManager = require("src.managers.taskManager")
local AnimationManager = require("src.managers.animationManager")

local MainScene = {}

-- Initialize the scene
function MainScene.initialize()
    -- Nothing specific to initialize for main scene yet
end

-- Update the scene
function MainScene.update(dt)
    -- Nothing to update continuously in this scene
end

-- Draw the scene
function MainScene.draw()
    -- Draw background
    love.graphics.setBackgroundColor(0.8, 0.8, 0.8)
    
    -- Draw background image
    local backgroundImage = love.graphics.newImage("assets/images/nonstore/background.png")
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(backgroundImage, 0, 0)
    
    -- Draw character in the center
    AnimationManager.draw((Constants.WINDOW_WIDTH / 2) - 100, 150)
    
    -- Draw task management interface
    TaskManager.draw()
end

-- Handle mouse press
function MainScene.mousepressed(x, y, button, scale)
    -- Handle task interactions
    return TaskManager.mousepressed(x, y, button, scale)
end

-- Handle key press
function MainScene.keypressed(key)
    -- Handle task-related key presses
    return TaskManager.handleKeyPress(key)
end

return MainScene