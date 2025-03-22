require("textbox")
require("task")
require("item")
taskList = {}
font = nil
function love.load()
    font = love.graphics.newFont(24)
    print("test") -- console printing test
    testTextbox = textbox.create(150,150,1000,16,"TASK")
    testItem = item.new("book", 10, false, "images/testImage.png")
    anotherTextbox = textbox.create(150,300,1000,15,"NOTTASK")
end
function love.update(dt)
    testTextbox:update()
    anotherTextbox:update()
end

function love.draw()
    love.graphics.setColor(1,1,1,1) -- DONT DELETE, COULD PREENT ANYTHING FROM BEING DRAWN
    --love.graphics.print("test", font, 150, 150)

    
    testTextbox:draw()
    anotherTextbox:draw()
    testItem:draw(150,300)
end

function love.mousepressed(x,y,button)
    testTextbox:mousepressed(x,y,button)
    anotherTextbox:mousepressed(x,y,button)
end
function love.keypressed(key)
    testTextbox:keypressed(key)
    anotherTextbox:keypressed(key)
end