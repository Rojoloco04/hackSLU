function love.load()
    font = love.graphics.newFont(24)
    print("test") -- console printing test
end


function love.update(dt)

end

function love.draw()
    love.graphics.setColor(1,1,1,1) -- DONT DELETE, COULD PREENT ANYTHING FROM BEING DRAWN
    love.graphics.print("test", font, 150, 150)
    

end
