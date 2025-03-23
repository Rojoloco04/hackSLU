function displayImage(imagePath, x, y)
    local image = love.graphics.newImage(imagePath)
    love.graphics.draw(image, x, y)
end