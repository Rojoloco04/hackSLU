-- src/config/settings.lua
-- Application settings

local Settings = {
    -- Debug settings
    DEBUG_MODE = false,
    SHOW_FPS = false,
    
    -- Game settings
    STARTING_MONEY = 0,
    STARTING_XP = 0,
    STARTING_LEVEL = 1,
    
    -- Animation settings
    DEFAULT_ANIMATION = "idle",
    ANIMATION_SPEED = 1.0,
    
    -- UI settings
    FONT_SIZE_SMALL = 16,
    FONT_SIZE_MEDIUM = 24,
    FONT_SIZE_LARGE = 30,
    
    -- Task settings
    TASK_REWARD_XP = 10,
    TASK_REWARD_MONEY = 5,
    MAX_ACTIVE_TASKS = 10,
    
    -- Streak settings
    STREAK_BONUS_MULTIPLIER = 0.1,  -- 10% bonus per day in streak
    MAX_STREAK_BONUS = 1.0,         -- Maximum 100% bonus
    
    -- Item settings
    ITEM_DISCOUNT_PER_LEVEL = 0.05,  -- 5% discount per level
    MAX_ITEM_DISCOUNT = 0.25,        -- Maximum 25% discount
    
    -- Audio settings
    MUSIC_VOLUME = 0.5,
    SFX_VOLUME = 0.7,
    
    -- Performance settings
    MAX_PARTICLES = 500,
    ENABLE_ANIMATIONS = true
}

return Settings