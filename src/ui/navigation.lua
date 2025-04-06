-- src/ui/navigation.lua
-- Navigation bar for switching between screens

local Constants = require("src.config.constants")
local Colors = require("src.config.colors")
local ColorUtils = require("src.utils.colorUtils")
local MathUtils = require("src.utils.mathUtils")

local Navigation = {
    currentPage = 1,
    barY = 755,
    
    tabs = {
        { name = "Home", scene = "Main" },
        { name = "Shop", scene = "Shop" },
        { name = "Resources", scene = "Resources" },
        { name = "Activities", scene = "Activities" }
    },
    
    -- Callback when page changes
    onPageChange = nil
}

-- Initialize the navigation system
function Navigation.initialize(initialPage)
    -- Set initial page if provided
    if initialPage then
        for i, tab in ipairs(Navigation.tabs) do
            if tab.scene == initialPage then
                Navigation.currentPage = i
                break
            end
        end
    end
end

-- Draw the navigation bar
function Navigation.draw()
    -- Calculate tab width
    local tabWidth = Constants.WINDOW_WIDTH / #Navigation.tabs
    
    -- Draw background for tabs
    for i = 1, #Navigation.tabs do
        -- Determine tab color (selected or normal)
        if i == Navigation.currentPage then
            ColorUtils.setColor(unpack(Colors.ACCENT_DARK))
        else
            ColorUtils.setColor(unpack(Colors.ACCENT))
        end
        
        -- Draw tab background
        love.graphics.rectangle(
            "fill", 
            (i - 1) * tabWidth, 
            Navigation.barY, 
            tabWidth, 
            Constants.WINDOW_HEIGHT - Navigation.barY
        )
    end
    
    -- Draw tab borders
    love.graphics.setColor(0, 0, 0)
    for i = 1, #Navigation.tabs do
        love.graphics.rectangle(
            "line", 
            (i - 1) * tabWidth, 
            Navigation.barY, 
            tabWidth, 
            Constants.WINDOW_HEIGHT - Navigation.barY
        )
    end
    
    -- Draw tab text
    local font = love.graphics.newFont(Constants.FONT_PATH, 16)
    love.graphics.setFont(font)
    
    for i, tab in ipairs(Navigation.tabs) do
        -- Calculate text position for centering
        local textWidth = font:getWidth(tab.name)
        local textX = (i - 1) * tabWidth + (tabWidth - textWidth) / 2
        local textY = Navigation.barY + 30
        
        love.graphics.print(tab.name, textX, textY)
    end
end

-- Handle mouse press on the navigation bar
function Navigation.mousepressed(x, y, button, scale)
    scale = scale or 1
    
    -- Only process clicks on the navigation bar
    if y < Navigation.barY * scale then
        return false
    end
    
    local tabWidth = (Constants.WINDOW_WIDTH / #Navigation.tabs) * scale
    local tabHeight = (Constants.WINDOW_HEIGHT - Navigation.barY) * scale
    
    -- Calculate tab centers for better hit detection
    local tabCenters = {}
    for i = 1, #Navigation.tabs do
        local centerX = ((i - 1) * tabWidth) + (tabWidth / 2)
        local centerY = (Navigation.barY * scale) + (tabHeight / 2)
        table.insert(tabCenters, {x = centerX, y = centerY})
    end
    
    -- Check which tab was clicked
    for i, center in ipairs(tabCenters) do
        local distance = MathUtils.distanceFromCircle(x, y, center.x, center.y, tabWidth / 2)
        
        if distance <= tabWidth / 2 then
            -- Tab changed
            local oldPage = Navigation.currentPage
            Navigation.currentPage = i
            
            -- Call the page change callback if provided
            if Navigation.onPageChange and oldPage ~= i then
                Navigation.onPageChange(Navigation.tabs[i].scene)
            end
            
            return true
        end
    end
    
    return false
end

-- Get current scene name
function Navigation.getCurrentScene()
    return Navigation.tabs[Navigation.currentPage].scene
end

-- Set the callback for page changes
function Navigation.setOnPageChange(callback)
    if type(callback) == "function" then
        Navigation.onPageChange = callback
    end
end

-- Set active page by scene name
function Navigation.setPageByScene(sceneName)
    for i, tab in ipairs(Navigation.tabs) do
        if tab.scene == sceneName then
            Navigation.currentPage = i
            return true
        end
    end
    
    return false
end

return Navigation