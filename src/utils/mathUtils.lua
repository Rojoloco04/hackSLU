-- src/utils/mathUtils.lua
-- Utility functions for mathematical operations

local MathUtils = {}

-- Calculate distance between a point and a circle
function MathUtils.distanceFromCircle(x, y, circleX, circleY, circleRadius)
    return math.sqrt((x - circleX)^2 + (y - circleY)^2)
end

-- Check if a point is inside a circle
function MathUtils.isPointInCircle(x, y, circleX, circleY, circleRadius)
    return MathUtils.distanceFromCircle(x, y, circleX, circleY, circleRadius) <= circleRadius
end

-- Check if a point is inside a rectangle
function MathUtils.isPointInRect(x, y, rectX, rectY, rectWidth, rectHeight)
    return x >= rectX and x <= rectX + rectWidth and
           y >= rectY and y <= rectY + rectHeight
end

-- Linear interpolation between two values
function MathUtils.lerp(a, b, t)
    return a + (b - a) * t
end

-- Clamp a value between min and max
function MathUtils.clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

return MathUtils