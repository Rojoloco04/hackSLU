-- src/ui/textbox.lua
-- TextBox UI component for text input

local Constants = require("src.config.constants") 
local Task = require("src.entities.task")

local TextBox = {}
TextBox.__index = TextBox

-- Create a new TextBox
function TextBox.create(x, y, maxLength, visibleChars, textType)
    local instance = {
        x = x,
        y = y,
        maxLength = maxLength or 100,
        visibleChars = visibleChars or 20,
        type = textType or "TEXT",
        font = love.graphics.newFont(Constants.FONT_PATH, 16),
        text = "",
        displayText = "Start typing",
        hover = false,
        selected = false,
        width = 0,
        height = 0,
        placeholder = "Start typing",
        onSubmit = nil  -- Callback function when Enter is pressed
    }
    
    -- Calculate dimensions based on font and visible characters
    instance.width = instance.font:getWidth("a") * instance.visibleChars + 1
    instance.height = instance.font:getHeight()
    
    return setmetatable(instance, TextBox)
end

-- Draw the TextBox
function TextBox:draw()
    -- Draw the background
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    
    -- Draw the text
    love.graphics.setFont(self.font)
    
    if self.text == "" then
        -- Draw placeholder text
        love.graphics.setColor(0.5, 0.5, 0.5, 0.75)
        love.graphics.print(self.placeholder, self.x, self.y)
    else
        -- Draw actual text
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.print(self.displayText, self.x, self.y)
    end
    
    -- Draw cursor when selected
    if self.selected then
        local time = love.timer.getTime()
        if math.floor(time * 2) % 2 == 0 then
            local textWidth = self.font:getWidth(self.displayText)
            if self.text == "" then
                textWidth = 0
            end
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.line(self.x + textWidth + 2, self.y, 
                              self.x + textWidth + 2, self.y + self.height)
        end
    end
end

-- Update TextBox state
function TextBox:update(dt)
    local mx, my = love.mouse.getPosition()
    mx = mx / (love.graphics.getWidth() / Constants.WINDOW_WIDTH)
    my = my / (love.graphics.getHeight() / Constants.WINDOW_HEIGHT)
    
    -- Update hover state
    self.hover = mx >= self.x and mx <= self.x + self.width and
                 my >= self.y and my <= self.y + self.height
end

-- Get the current text value
function TextBox:getText()
    return self.text
end

-- Set the text value
function TextBox:setText(newText)
    self.text = newText or ""
    self:updateDisplayText()
end

-- Update the displayed text (handles long text)
function TextBox:updateDisplayText()
    if #self.text > self.visibleChars then
        -- Show the last 'visibleChars' characters
        self.displayText = string.sub(
            self.text, 
            #self.text - self.visibleChars + 1, 
            #self.text
        )
    else
        self.displayText = self.text
    end
end

-- Handle mouse press
function TextBox:mousepressed(x, y, button)
    -- Scale mouse coordinates if needed
    x = x / (love.graphics.getWidth() / Constants.WINDOW_WIDTH)
    y = y / (love.graphics.getHeight() / Constants.WINDOW_HEIGHT)
    
    -- Check if clicked inside textbox
    if x >= self.x and x <= self.x + self.width and 
       y >= self.y and y <= self.y + self.height then
        self.selected = true
    else
        self.selected = false
    end
end

-- Handle key press
function TextBox:keypressed(key)
    if not self.selected then
        return
    end
    
    if key == "backspace" then
        -- Remove last character
        if #self.text > 0 then
            self.text = string.sub(self.text, 1, #self.text - 1)
            self:updateDisplayText()
        end
    elseif key == "return" or key == "kpenter" then
        if self.onSubmit then
            self.onSubmit(self.text)
        end
        self:setText("")
    elseif key == "escape" then
        -- Deselect the textbox
        self.selected = false
    elseif #self.text < self.maxLength then
        -- Add character if it's a single printable character
        if #key == 1 and string.match(key, "%g") then
            -- Apply shift for uppercase
            if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
                key = string.upper(key)
            end
            self.text = self.text .. key
            self:updateDisplayText()
        elseif key == "space" then
            self.text = self.text .. " "
            self:updateDisplayText()
        end
    end
end

-- Set a callback function for when Enter is pressed
function TextBox:setOnSubmit(callback)
    if type(callback) == "function" then
        self.onSubmit = callback
    end
end

-- Set the placeholder text
function TextBox:setPlaceholder(text)
    self.placeholder = text or "Start typing"
end

return TextBox