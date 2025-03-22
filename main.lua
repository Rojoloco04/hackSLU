package.path = package.path .. ";./?.lua"
require("textbox")
require("task")
require("item")
require("data")
require("shopManager")
require("foundation")

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
    
    addItem(testItem)
end

function love.update(dt)

end

function love.draw()
    love.graphics.setBackgroundColor(0.9,0.9,0.9)
    buildTaskContainer()
    buildTaskWindows()
    buildTaskBar()
end

function love.mousepressed(x,y,button)
    testTextbox:mousepressed(x,y,button)
    anotherTextbox:mousepressed(x,y,button)
end
function love.keypressed(key)
    testTextbox:keypressed(key)
    anotherTextbox:keypressed(key)
end