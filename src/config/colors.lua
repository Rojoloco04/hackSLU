-- src/config/colors.lua
-- Centralized color definitions for consistent UI

local Colors = {
    -- Primary colors
    PRIMARY_DARK = {0, 36, 77},        -- Dark blue
    PRIMARY_LIGHT = {83, 195, 238},    -- Light blue
    ACCENT = {237, 139, 0},            -- Orange
    ACCENT_DARK = {190, 110, 0},       -- Dark orange
    
    -- UI colors
    BACKGROUND = {204, 204, 204},      -- Light gray
    TEXT = {0, 0, 0},                  -- Black
    TEXT_LIGHT = {255, 255, 255},      -- White
    TEXT_DISABLED = {128, 128, 128},   -- Gray
    
    -- Feedback colors
    SUCCESS = {0, 255, 0},             -- Green
    ERROR = {255, 0, 0},               -- Red
    WARNING = {255, 255, 0},           -- Yellow
    INFO = {0, 0, 255},                -- Blue
    
    -- Transparency
    OVERLAY = {0, 0, 0, 0.7},          -- Dark overlay
    TRANSPARENT = {0, 0, 0, 0}         -- Fully transparent
}

return Colors