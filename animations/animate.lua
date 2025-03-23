package.path = package.path .. ";../?.lua"
require("data")

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

function setAnimation(animation)
    if animation == currentAnimation then
        return -- Avoid reloading the same animation
    end

    currentAnimation = animation

    if animation == "idle" then
        loadAnimation({
            "images/nonstore/billy.png", 
            "images/nonstore/billyWave1.png",
            "images/nonstore/billyWave2.png",
            "images/nonstore/billyWave3.png",
            "images/nonstore/billyWave3.png",
            "images/nonstore/billyWave2.png",
            "images/nonstore/billyWave1.png",
            "images/nonstore/billy.png"
        }, 0.1)
    elseif animation == "jump" then
        loadAnimation({ 
            "images/nonstore/billy.png",
            "images/nonstore/billySquat.png",
            "images/nonstore/billySquat.png",
            "images/nonstore/billySquat.png",
            "images/nonstore/billySquat.png",
            "images/nonstore/billy.png"
        }, 0.1)
    elseif animation == "blink" then
        loadAnimation({
            "images/nonstore/billy.png",
            "images/nonstore/billyEyesClosed.png",
            "images/nonstore/billy.png" 
        }, 0.1)
    end
end

function drawStats()
    data = readUserData()
    font = love.graphics.newFont("assets/Silkscreen-Regular.ttf", 16)
    love.graphics.setColor(0,0,0)
    love.graphics.print("Money: " .. data["money"], font, 5, 15)
    love.graphics.print("XP: " .. math.floor(data["xp"]) .. " / " .. math.floor(math.sqrt(data["level"])*100), font, 230, 15)
    love.graphics.print("Level: " .. data["level"], font, 400, 15)
    love.graphics.print("Streak: " .. data["streak"], font, 125, 15)
end