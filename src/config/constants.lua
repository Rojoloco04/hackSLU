-- src/config/constants.lua
-- Game constants and configuration values

local Constants = {
    -- Window dimensions
    WINDOW_WIDTH = 507,
    WINDOW_HEIGHT = 900,
    
    -- UI dimensions
    TASK_HEIGHT = 78,
    TASK_GAP = 10,
    TASK_CONTAINER_X = 20,
    TASK_CONTAINER_Y = 300,
    TASK_CONTAINER_WIDTH = 467,
    TASK_CONTAINER_HEIGHT = 450,
    TASK_BORDER_RADIUS = 15,
    
    -- Navigation
    NAV_HEIGHT = 145,
    NAV_BAR_Y = 755,
    NAV_TABS = 4,
    
    -- Button dimensions
    ADD_BUTTON_X = 465,
    ADD_BUTTON_Y = 728,
    ADD_BUTTON_RADIUS = 30,
    
    -- Animation
    FRAME_DELAY = 0.1,
    
    -- Game mechanics
    TASK_COMPLETE_XP = 10,
    TASK_COMPLETE_MONEY = 5,
    
    -- Time constants
    TIMEZONE_OFFSET = -5, -- STL timezone
    
    -- File paths
    USER_DATA_FILE = "userdata.json",
    ITEM_DATA_FILE = "itemdata.json",
    FONT_PATH = "assets/fonts/Silkscreen-Regular.ttf",
    
    -- Scene names
    SCENES = {
        MAIN = "Main",
        SHOP = "Shop",
        RESOURCES = "Resources",
        ACTIVITIES = "Activities"
    }
}

return Constants