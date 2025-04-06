-- src/scenes/scene.lua
-- Base class for all scenes

local Scene = {
    name = "BaseScene",
    initialized = false
}

-- Create a new scene
function Scene:new(name)
    local instance = {
        name = name or "UnnamedScene",
        initialized = false
    }
    
    setmetatable(instance, self)
    self.__index = self
    
    return instance
end

-- Initialize the scene
function Scene:initialize()
    self.initialized = true
end

-- Update scene state
function Scene:update(dt)
    -- Override in derived scenes
end

-- Draw the scene
function Scene:draw()
    -- Override in derived scenes
    love.graphics.print("Scene '" .. self.name .. "' has no draw implementation", 10, 10)
end

-- Handle mouse press
function Scene:mousepressed(x, y, button, scale)
    -- Override in derived scenes
    return false
end

-- Handle mouse release
function Scene:mousereleased(x, y, button, scale)
    -- Override in derived scenes
    return false
end

-- Handle key press
function Scene:keypressed(key)
    -- Override in derived scenes
    return false
end

-- Handle key release
function Scene:keyreleased(key)
    -- Override in derived scenes
    return false
end

-- Enter the scene (called when scene becomes active)
function Scene:enter(previous)
    -- Override in derived scenes
end

-- Exit the scene (called when scene becomes inactive)
function Scene:exit(next)
    -- Override in derived scenes
end

-- Reset the scene state
function Scene:reset()
    -- Override in derived scenes
end

return Scene