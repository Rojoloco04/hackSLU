level = 0
xp = 0

function levelUp()
    if level >= 5 then
        rebirth()
    else
        level = level + 1
    end
end
--[[ 
function xpGain(amount)
    xp =  xp + 25
    if xp >= 100
        levelUp()
    end
end

function rebirth()
    level = 0
    -- call a function that plays an animation for rebirth 
]]