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
require("animations/animate")
require("itemData")

items = {}
images = {}
taskList = {}
currPage = "Main" --WHEN USER PRESSES PAGE CHANGE THIS VALUE TO ONE OF THE PAGE STRINGS
data = readUserData()

function love.load()
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
    getAllItems()

    setAnimation("idle")
end

function love.update(dt)
    updateAnimation(dt)
end

function love.draw()
    local currentAnimation = "idle"
    love.graphics.scale(scale_factor, scale_factor)
    
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
    if currPage == "Main" or currPage == "Shop" then
        displayImage("images/nonstore/background.png", 0, 0)
        drawIdle((507/2) - 100, 150)
    end    
    buildGlobal()
    drawStats()
end

function love.mousepressed(x,y,button)
    testTextbox:mousepressed(x,y,button)
    anotherTextbox:mousepressed(x,y,button)
    if currPage == "Main" then
        if not addTaskclicked then
            pressTasksList(x,y)
            markTaskOnClick(x, y)
            loadTasks()
        end
        interactTaskButton(x,y)
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