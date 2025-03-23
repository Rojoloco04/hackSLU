item = {}
item.__index = item

function item.new(id,name,price,img)
    local instance = {}
    setmetatable(instance,item)
    instance.id = id
    instance.name = name
    instance.price = price
    instance.image = love.graphics.newImage(img)
    return instance
end

-- FIX THIS
function item:draw(x,y)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(self.image, x, y)
    love.graphics.setColor(1, 1, 1) 
    love.graphics.print(self.name, x, y + self.image:getHeight() + 5)
    
    
end

return item