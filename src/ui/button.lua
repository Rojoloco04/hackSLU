-- src/ui/button.lua
-- Button UI component

local Constants = require("src.config.constants")
local Colors = require("src.config.colors")
local ColorUtils = require("src.utils.colorUtils")
local MathUtils = require("src.utils.mathUtils")

local Button = {}
Button.__index = Button

-- Create a new rectangular button
function Button.createRect(x, y, width, height, text, options)
    options = options or {}
    
    local instance = {
        -- Position and size
        x = x,
        y = y,
        width = width,
        height = height,
        
        -- Appearance
        text = text or "",
        shape = "rect",
        cornerRadius = options.cornerRadius or 5,
        fontSize = options.fontSize or 16,
        font = love.graphics.newFont(Constants.FONT_PATH, options.fontSize or 16),
        
        -- Colors
        normalColor = options.normalColor or Colors.PRIMARY_LIGHT,
        hoverColor = options.hoverColor or Colors.PRIMARY_DARK,
        pressedColor = options.pressedColor or Colors.ACCENT,
        textColor = options.textColor or Colors.TEXT,
        
        -- State
        hover = false,
        pressed = false,
        enabled = options.enabled ~= false,
        
        -- Callback
        onClick = options.onClick
    }
    
    return setmetatable(instance, Button)
end

-- Create a new circular button
function Button.createCircle(x, y, radius, text, options)
    options = options or {}
    
    local instance = {
        -- Position and size
        x = x,
        y = y,
        radius = radius,
        
        -- Appearance
        text = text or "",
        shape = "circle",
        fontSize = options.fontSize or 16,
        font = love.graphics.newFont(Constants.FONT_PATH, options.fontSize or 16),
        
        -- Colors
        normalColor = options.normalColor or Colors.PRIMARY_LIGHT,
        hoverColor = options.hoverColor or Colors.PRIMARY_DARK,
        pressedColor = options.pressedColor or Colors.ACCENT,
        textColor = options.textColor or Colors.TEXT,
        
        -- State
        hover = false,
        pressed = false,
        enabled = options.enabled ~= false,
        
        -- Callback
        onClick = options.onClick
    }
    
    return setmetatable(instance, Button)
end

-- Update button state
function Button:update(dt)
    local mx, my = love.mouse.getPosition()
    mx = mx / (love.graphics.getWidth() / Constants.WINDOW_WIDTH)
    my = my / (love.graphics.getHeight() / Constants.WINDOW_HEIGHT)
    
    -- Check if mouse is over button
    if self.shape == "rect" then
        self.hover = mx >= self.x and mx <= self.x + self.width and
                     my >= self.y and my <= self.y + self.height
    else -- circle
        self.hover = MathUtils.distanceFromCircle(mx, my, self.x, self.y, self.radius) <= self.radius
    end
end

-- Draw the button
function Button:draw()
    -- Set color based on state
    local color = self.normalColor
    if not self.enabled then
        -- Disabled state: desaturate color
        color = {color[1]*0.5, color[2]*0.5, color[3]*0.5}
    elseif self.pressed then
        color = self.pressedColor
    elseif self.hover then
        color = self.hoverColor
    end
    
    -- Draw button shape
    love.graphics.setColor(ColorUtils.convertRGB(unpack(color)))
    
    if self.shape == "rect" then
        love.graphics.rectangle(
            "fill", 
            self.x, 
            self.y, 
            self.width, 
            self.height, 
            self.cornerRadius, 
            self.cornerRadius
        )
    else -- circle
        love.graphics.circle("fill", self.x, self.y, self.radius)
    end
    
    -- Draw text if present
    if self.text and self.text ~= "" then
        love.graphics.setFont(self.font)
        love.graphics.setColor(ColorUtils.convertRGB(unpack(self.textColor)))
        
        -- Calculate text position to center it
        local textWidth = self.font:getWidth(self.text)
        local textHeight = self.font:getHeight()
        
        local textX, textY
        
        if self.shape == "rect" then
            textX = self.x + (self.width - textWidth) / 2
            textY = self.y + (self.height - textHeight) / 2
        else -- circle
            textX = self.x - textWidth / 2
            textY = self.y - textHeight / 2
        end
        
        love.graphics.print(self.text, textX, textY)
    end
end

-- Draw a custom plus sign on a button
function Button:drawPlusSign(lineWidth, lineLength)
    if not self.enabled then
        return
    end
    
    lineWidth = lineWidth or 5
    lineLength = lineLength or 30
    
    love.graphics.setColor(0, 0, 0)
    
    -- Draw vertical line
    love.graphics.rectangle(
        "fill", 
        self.x - lineWidth/2, 
        self.y - lineLength/2, 
        lineWidth, 
        lineLength
    )
    
    -- Draw horizontal line
    love.graphics.rectangle(
        "fill", 
        self.x - lineLength/2, 
        self.y - lineWidth/2, 
        lineLength, 
        lineWidth
    )
end

-- Handle mouse press on the button
function Button:mousepressed(x, y, button, scale)
    -- Scale coordinates if needed
    scale = scale or 1
    local sx = x / scale
    local sy = y / scale
    
    -- Check if button is pressed
    local isPressedOn = false
    
    if self.shape == "rect" then
        isPressedOn = sx >= self.x and sx <= self.x + self.width and
                      sy >= self.y and sy <= self.y + self.height
    else -- circle
        isPressedOn = MathUtils.distanceFromCircle(
            sx, sy, self.x, self.y, self.radius
        ) <= self.radius
    end
    
    -- Only register press if enabled
    if isPressedOn and self.enabled then
        self.pressed = true
        return true
    end
    
    return false
end

-- Handle mouse release
function Button:mousereleased(x, y, button, scale)
    -- Scale coordinates if needed
    scale = scale or 1
    local sx = x / scale
    local sy = y / scale
    
    -- Check if release is over the button
    local isReleasedOn = false
    
    if self.shape == "rect" then
        isReleasedOn = sx >= self.x and sx <= self.x + self.width and
                      sy >= self.y and sy <= self.y + self.height
    else -- circle
        isReleasedOn = MathUtils.distanceFromCircle(
            sx, sy, self.x, self.y, self.radius
        ) <= self.radius
    end
    
    -- If button was pressed and release is over button, trigger click
    if self.pressed and isReleasedOn and self.enabled and self.onClick then
        self.onClick()
    end
    
    -- Reset pressed state
    self.pressed = false
    
    return isReleasedOn and self.enabled
end

-- Set enabled/disabled state
function Button:setEnabled(enabled)
    self.enabled = enabled
end

-- Set button text
function Button:setText(text)
    self.text = text or ""
end

-- Set click callback
function Button:setOnClick(callback)
    if type(callback) == "function" then
        self.onClick = callback
    end
end

return Button