-- main.lua
-- Main entry point for Billiken Balance application

-- Add source directory to path
package.path = package.path .. ";./?.lua"

-- Import required modules
local Constants = require("src.config.constants")
local DataService = require("src.services.dataService")
local UserManager = require("src.managers.userManager")
local AnimationManager = require("src.managers.animationManager")
local TaskManager = require("src.managers.taskManager")
local Navigation = require("src.ui.navigation")

-- Scene modules
local MainScene = require("src.scenes.mainScene")
local ShopScene = require("src.scenes.shopScene")
local ResourcesScene = require("src.scenes.resourcesScene")
local ActivityScene = require("src.scenes.activityScene")

-- Current scene
local currentScene = "Main"
local scenes = {}
local scale_factor = 1

-- Initialize the application
function love.load()
    -- Set up window
    love.window.setMode(0, 0)
    local screen_width = Constants.WINDOW_WIDTH
    local screen_height = Constants.WINDOW_HEIGHT
    love.window.setMode(screen_width, screen_height)
    
    -- Calculate scale factor
    local scale_x = screen_width / Constants.WINDOW_WIDTH
    local scale_y = screen_height / Constants.WINDOW_HEIGHT
    scale_factor = scale_x
    
    -- Initialize data
    DataService.initializeUserData()
    DataService.processEndOfDay()
    
    -- Initialize managers
    AnimationManager.initialize()
    TaskManager.initialize()
    Navigation.initialize(currentScene)
    
    -- Set up scene change callback
    Navigation.setOnPageChange(function(newScene)
        currentScene = newScene
    end)
    
    -- Initialize scenes
    scenes[Constants.SCENES.MAIN] = MainScene
    scenes[Constants.SCENES.SHOP] = ShopScene
    scenes[Constants.SCENES.RESOURCES] = ResourcesScene
    scenes[Constants.SCENES.ACTIVITIES] = ActivityScene
    
    -- Initialize each scene
    for _, scene in pairs(scenes) do
        if scene.initialize then
            scene.initialize()
        end
    end
end

-- Update game state
function love.update(dt)
    -- Update animation system
    AnimationManager.update(dt)
    
    -- Update current scene
    local scene = scenes[currentScene]
    if scene and scene.update then
        scene.update(dt)
    end
end

-- Draw everything
function love.draw()
    -- Apply scaling
    love.graphics.scale(scale_factor, scale_factor)
    
    -- Draw current scene
    local scene = scenes[currentScene]
    if scene and scene.draw then
        scene.draw()
    end
    
    -- Draw navigation bar
    Navigation.draw()
    
    -- Draw player stats
    UserManager.drawStats()
end

-- Handle mouse press
function love.mousepressed(x, y, button)
    -- Scale mouse coordinates
    local sx = x / scale_factor
    local sy = y / scale_factor
    
    -- Check navigation first
    if Navigation.mousepressed(x, y, button, scale_factor) then
        return
    end
    
    -- Then let the current scene handle it
    local scene = scenes[currentScene]
    if scene and scene.mousepressed then
        scene.mousepressed(x, y, button, scale_factor)
    end
end

-- Handle key press
function love.keypressed(key)
    -- Let the current scene handle key press
    local scene = scenes[currentScene]
    if scene and scene.keypressed then
        scene.keypressed(key)
    end
end

-- Handle window resize
function love.resize(w, h)
    -- Recalculate scale factor
    local scale_x = w / Constants.WINDOW_WIDTH
    local scale_y = h / Constants.WINDOW_HEIGHT
    scale_factor = scale_x
end