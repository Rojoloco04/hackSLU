function love.load()
    font = love.graphics.newFont(24)
end


function love.update(dt)

end

function love.draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.print("test", font, 150, 150)
end
