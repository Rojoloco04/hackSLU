require("textbox")
require("task")
taskList = {}

function love.load()
    font = love.graphics.newFont(24)
    print("test") -- console printing test
    testTextbox = textbox.create(150,150,1000, 16)
end


function love.update(dt)
    testTextbox:update()
end

function love.draw()
    love.graphics.setColor(1,1,1,1) -- DONT DELETE, COULD PREENT ANYTHING FROM BEING DRAWN
    --love.graphics.print("test", font, 150, 150)
    testTextbox:draw()

end


function love.mousepressed(x,y,button)
    testTextbox:mousepressed(x,y,button)
end
function love.keypressed(key)
    testTextbox:keypressed(key)
end