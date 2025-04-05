-- conf.lua
-- Love2D configuration file

function love.conf(t)
    -- Application identity
    t.identity = "BillikenBalance"
    t.version = "11.3"
    t.console = false
    
    -- Window configuration
    t.window.title = "Billiken Balance"
    t.window.width = 507
    t.window.height = 900
    t.window.resizable = true
    t.window.minwidth = 320
    t.window.minheight = 568
    
    -- Modules configuration
    t.modules.audio = true
    t.modules.data = true
    t.modules.event = true
    t.modules.font = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = false  -- Not used in this application
    t.modules.sound = true
    t.modules.system = true
    t.modules.thread = true
    t.modules.timer = true
    t.modules.touch = true
    t.modules.video = false    -- Not used in this application
    t.modules.window = true
end