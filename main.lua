package.path = package.path .. ";./?.lua"
require("textbox")
require("task")
require("item")
require("data")
require("shopManager")
require("Billy")
require("addTask")
require("init")
require("assets/globalFont")


currPage = "Main" --WHEN USER PRESSES PAGE CHANGE THIS VALUE TO ONE OF THE PAGE STRINGS
taskList = {}
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
    
    -- testing
    startUp()
    endOfDay()
    loadTasks()
    task1 = Task.new("tasking")
    addActiveTask(task1)
    print("TASK LIST LENGTH"..#taskList)
end

function love.update(dt)
    
end

function love.draw()
    love.graphics.scale(scale_factor,scale_factor)
    buildGlobal()
    if currPage ~= "Resources" and currPage ~= "Activites" and currPage ~= "Settings" then
        buildBillyCage()
    end    
    
    if currPage == "Main" then
        drawMain()
    elseif currPage == "Shop" then 
        drawShop()
    elseif currPage == "Resources" then
        drawResources()
    elseif currPage == "Activities" then
        drawActivities()
    elseif currPage == "Settings" then
        drawSettings()
    else
        error("Incorrect Page")
    end
end


function love.mousepressed(x,y,button)
    testTextbox:mousepressed(x,y,button)
    anotherTextbox:mousepressed(x,y,button)
    if currPage == "Main" then
        interactTaskButton(x,y)
    elseif currPage == "Shop" then
        interactShopButton(x,y)
    end
    
end

function love.keypressed(key)
    testTextbox:keypressed(key)
    anotherTextbox:keypressed(key)
    typeTaskButton(key)
end