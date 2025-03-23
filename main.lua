package.path = package.path .. ";./?.lua"
require("textbox")
require("task")
require("item")
require("data")
require("shopManager")
require("addTask")
require("init")
require("assets/globalFont")
require("animations/displayImage")
require("animations/BillyIdle")

items = {}
images = {}
taskList = {}
currPage = "Main" --WHEN USER PRESSES PAGE CHANGE THIS VALUE TO ONE OF THE PAGE STRINGS
data = readUserData()

function love.load()

    -- ON SOMETHING
    idle = loadAnimation({
    "images/nonstore/billy.png", 
    "images/nonstore/billyWave1.png",
    "images/nonstore/billyWave2.png",
    "images/nonstore/billyWave3.png",
    "images/nonstore/billyWave3.png",
    "images/nonstore/billyWave2.png",
    "images/nonstore/billyWave1.png",
    "images/nonstore/billy.png"}, 0.1)

    -- blink = loadAnimation({
    -- "images/nonstore/billy.png",
    -- "images/nonstore/billyEyesClosed.png",
    -- "images/nonstore/billy.png" 
    -- }, 0.1)

    -- jump = loadAnimation({ -_ON LEVEL UP
    --     "images/nonstore/billy.png"
    --     "images/nonstore/billySquat.png"
    --     "images/nonstore/billySquat.png"
    --     "images/nonstore/billySquat.png"
    --     "images/nonstore/billySquat.png"
    --     "images/nonstore/billy.png"
    -- }, 0.1)

    font = love.graphics.newFont("assets/Silkscreen-Regular.ttf", 20)
    love.graphics.setFont(font)
    love.window.setMode(0, 0)

    screen_width = 507--love.graphics.getWidth() -- this is the only thing that affects scale
    screen_height = 900 --love.graphics.getHeight()
    love.window.setMode(screen_width, screen_height)

    local target_width = 507
    local target_height = 900
    scale_x = screen_width / target_width
    scale_y = screen_height / target_height
    
    scale_factor = scale_x
    testTextbox = textbox.create(150,150,1000,16,"TASK")
    anotherTextbox = textbox.create(150,300,1000,15,"NOTTASK")
    
    -- initialization
    startUp()
    endOfDay()
    loadTasks()

end

function love.update(dt)
    updateAnimation(dt)
end

function love.draw()
    love.graphics.scale(scale_factor, scale_factor)
    
    if currPage == "Main" or currPage == "Shop" then
        displayImage("images/nonstore/background.png", 0, 0)
        drawIdle((507/2) - 100, 150)
    end    
    
    buildGlobal()
    
    if currPage == "Main" then
        drawMain()
    elseif currPage == "Shop" then 
        drawShop()
    elseif currPage == "Resources" then
        drawResources()
    elseif currPage == "Activities" then
        drawActivity()
    else
        error("Incorrect Page")
    end

end


function love.mousepressed(x,y,button)
    testTextbox:mousepressed(x,y,button)
    anotherTextbox:mousepressed(x,y,button)
    if currPage == "Main" then
        interactTaskButton(x,y)
        if not addTaskclicked then
            pressTasksList(x,y)
        end
    elseif currPage == "Shop" then
        interactShopButton(x,y)
    end
    globalPress(x,y)
end

function love.keypressed(key)
    testTextbox:keypressed(key)
    anotherTextbox:keypressed(key)
    typeTaskButton(key)
end