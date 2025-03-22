item = {}
item.__index = item

function item.new(name,price,bought,image)
    temp = {}
    setmetatable(temp,item)
    temp.name = name
    temp.price = price
    temp.bought = bought
    temp.image = love.graphics.newImage(image)
    return temp
end

function item:buy()
    temp.price = 0
    temp.bought = true
end

function item:draw(x,y)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(self.image, x, y)
    love.graphics.setColor(1, 1, 1) 
    love.graphics.print(self.name, x, y + self.image:getHeight() + 5)
    
    if not self.bought then
        love.graphics.print("Price: " .. self.price, x, y + self.image:getHeight() + 25)
    else
        love.graphics.print("Bought", x, y + self.image:getHeight() + 25)
    end
end

return item


