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

font = setGlobalFont()

function love.load()
    font = love.graphics.newFont(24)
    love.window.setMode(0, 0)
    screen_width = 507--love.graphics.getWidth() -- this is the only thing that affects scale
    screen_height = 900 --love.graphics.getHeight()
    print(screen_width)
    print(screen_height)
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

    testItem = item.new(2, "book", 10, "images/book.png")
    purchase(testItem)

    changeName("Jack")
    print(getName())
    streakUp()
    print(getStreak())
  
    testTask = Task.new("Clean car")
    addActiveTask(testTask)
    testTask:complete()

    testTask = Task.new("Clean house")
    addActiveTask(testTask)
    testTask = Task.new("Buy groceries")
    addActiveTask(testTask)

    loadTasks()
    for _, task in ipairs(taskList) do
        print(task)
    end

    date = currentDate()
    storeDueDate(date)
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