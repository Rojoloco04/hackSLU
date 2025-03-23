package.path = package.path .. ";./?.lua"
require("textbox")
require("task")
require("item")
require("data")
require("shopManager")
require("foundationMain")
require("foundationGlobal")
require("foundationShop")
require("foundationSettings")
require("foundationResources")
require("Billy")
require("addTask")

currPage = "Resources" --WHEN USER PRESSES PAGE CHANGE THIS VALUE TO ONE OF THE PAGE STRINGS
taskList = {}
data = readUserData()

font = nil

function love.load()
    font = love.graphics.newFont(24)
    testTextbox = textbox.create(150,150,1000,16,"TASK")
    anotherTextbox = textbox.create(150,300,1000,15,"NOTTASK")

    -- testing
    startUp()

    testItem = item.new(2, "book", 10, false, "images/book.png")
    purchase(testItem)

    changeName("Jack")
    print(getName())
    streakUp()
    print(getStreak())
end

function love.update(dt)

end

function love.draw()
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
    interactTaskButton(x,y)
end

function love.keypressed(key)
    testTextbox:keypressed(key)
    anotherTextbox:keypressed(key)
    typeTaskButton(key)
end