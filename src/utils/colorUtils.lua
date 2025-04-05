-- src/utils/colorUtils.lua
-- Utility functions for color handling

local ColorUtils = {}

-- Convert RGB values (0-255) to LÖVE color format (0-1)
function ColorUtils.convertRGB(r, g, b, a)
    local alpha = a or 1
    return r / 255, g / 255, b / 255, alpha
end

-- Create a color table from RGB values
function ColorUtils.createColor(r, g, b, a)
    return {
        r = r / 255,
        g = g / 255,
        b = b / 255,
        a = a or 1
    }
end

-- Set current drawing color from RGB values
function ColorUtils.setColor(r, g, b, a)
    love.graphics.setColor(ColorUtils.convertRGB(r, g, b, a))
end

-- Reset color to white
function ColorUtils.resetColor()
    love.graphics.setColor(1, 1, 1, 1)
end

return ColorUtils