item = {}
item.__index = item

function item.new(id,name,price,image)
    local instance = {}
    setmetatable(instance,item)
    instance.id = id
    instance.name = name
    instance.price = price
    instance.image = love.graphics.newImage(image)
    return instance
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