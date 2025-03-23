local frames = {}

local currentFrame = 1
local frameTimer = 0
local frameDelay = 0.1  -- Time between frame switches (in seconds)

-- Function to load the frames and set up the animation
function loadAnimation(framePaths, delay)
    -- Reset variables for a fresh animation
    frames = {}
    currentFrame = 1
    frameTimer = 0
    frameDelay = delay

    for i, path in ipairs(framePaths) do
        frames[i] = love.graphics.newImage(path)
    end
end

function updateAnimation(dt)
    -- Update the frame timer
    frameTimer = frameTimer + dt
    if frameTimer >= frameDelay then
        frameTimer = 0
        currentFrame = currentFrame + 1
        if currentFrame > #frames then
            currentFrame = 1 
        end
    end
end

function drawIdle(x, y)
    love.graphics.draw(frames[currentFrame], x, y)
end