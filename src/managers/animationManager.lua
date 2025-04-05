-- src/managers/animationManager.lua
-- Manages character animations

local Constants = require("src.config.constants")

local AnimationManager = {
    animations = {
        idle = {
            frames = {},
            framePaths = {
                "images/nonstore/billy.png", 
                "images/nonstore/billyWave1.png",
                "images/nonstore/billyWave2.png",
                "images/nonstore/billyWave3.png",
                "images/nonstore/billyWave3.png",
                "images/nonstore/billyWave2.png",
                "images/nonstore/billyWave1.png",
                "images/nonstore/billy.png"
            },
            frameDelay = 0.1
        },
        jump = {
            frames = {},
            framePaths = { 
                "images/nonstore/billy.png",
                "images/nonstore/billySquat.png",
                "images/nonstore/billySquat.png",
                "images/nonstore/billySquat.png",
                "images/nonstore/billySquat.png",
                "images/nonstore/billy.png"
            },
            frameDelay = 0.1
        },
        blink = {
            frames = {},
            framePaths = {
                "images/nonstore/billy.png",
                "images/nonstore/billyEyesClosed.png",
                "images/nonstore/billy.png" 
            },
            frameDelay = 0.1
        }
    },
    currentAnimation = nil,
    currentFrame = 1,
    frameTimer = 0,
    frameDelay = 0.1
}

-- Initialize the animation system
function AnimationManager.initialize()
    for name, animation in pairs(AnimationManager.animations) do
        animation.frames = {}
        for i, path in ipairs(animation.framePaths) do
            animation.frames[i] = love.graphics.newImage(path)
        end
    end
    
    -- Set default animation
    AnimationManager.setAnimation("idle")
end

-- Update the animation state
function AnimationManager.update(dt)
    -- Skip if no animation is active
    if not AnimationManager.currentAnimation then
        return
    end
    
    -- Update the frame timer
    AnimationManager.frameTimer = AnimationManager.frameTimer + dt
    
    -- Check if it's time to change frames
    if AnimationManager.frameTimer >= AnimationManager.frameDelay then
        AnimationManager.frameTimer = 0
        AnimationManager.currentFrame = AnimationManager.currentFrame + 1
        
        -- Loop back to the first frame if needed
        local anim = AnimationManager.animations[AnimationManager.currentAnimation]
        if AnimationManager.currentFrame > #anim.frames then
            AnimationManager.currentFrame = 1
            
            -- If it's a one-shot animation, go back to idle
            if AnimationManager.currentAnimation ~= "idle" then
                AnimationManager.setAnimation("idle")
            end
        end
    end
end

-- Draw the current animation frame at the specified position
function AnimationManager.draw(x, y)
    if not AnimationManager.currentAnimation then
        return
    end
    
    local anim = AnimationManager.animations[AnimationManager.currentAnimation]
    local frame = anim.frames[AnimationManager.currentFrame]
    
    if frame then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(frame, x, y)
    end
end

-- Set the current animation
function AnimationManager.setAnimation(animationName)
    -- Skip if already playing this animation
    if AnimationManager.currentAnimation == animationName then
        return
    end
    
    -- Check if the animation exists
    if not AnimationManager.animations[animationName] then
        error("Animation not found: " .. tostring(animationName))
        return
    end
    
    -- Set the new animation
    AnimationManager.currentAnimation = animationName
    AnimationManager.currentFrame = 1
    AnimationManager.frameTimer = 0
    AnimationManager.frameDelay = AnimationManager.animations[animationName].frameDelay
end

-- Add a new animation
function AnimationManager.addAnimation(name, framePaths, frameDelay)
    if not name or not framePaths or #framePaths == 0 then
        error("Invalid animation parameters")
        return false
    end
    
    -- Create the animation data
    AnimationManager.animations[name] = {
        frames = {},
        framePaths = framePaths,
        frameDelay = frameDelay or Constants.FRAME_DELAY
    }
    
    -- Load the frames
    for i, path in ipairs(framePaths) do
        AnimationManager.animations[name].frames[i] = love.graphics.newImage(path)
    end
    
    return true
end

return AnimationManager
