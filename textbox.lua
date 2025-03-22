textbox = {}
textbox.__index = textbox
require("task")

function textbox.create(x,y,max,size, textType)
    local temp = {}
    setmetatable(temp,textbox)

    temp.size = size
    temp.type = textType
    temp.font = love.graphics.newFont(20)
    temp.hover = false
    temp.selected = false
    temp.text = ""
    temp.displayText = temp.text
    temp.max = max
    temp.width= temp.font:getWidth("a")*size + 1
    temp.height = temp.font:getHeight()
    temp.x = x
    temp.y = y

    return temp
end

function textbox:draw()
    love.graphics.setColor(1,1,1,1)

    love.graphics.polygon("fill", self.x, self.y, self.x + self.width, self.y, self.x + self.width, self.y + self.height, self.x, self.y + self.height)
	love.graphics.setFont(self.font)	
	love.graphics.setColor(0,0,0,1)
	love.graphics.print(self.displayText, self.x, self.y)	
end

function textbox:update()
    local x = love.mouse.getX()
    local y = love.mouse.getY()
    if x > self.x and y > self.y and x < self.x + self.width and y < self.y + self.height then
        self.hover = true
    else
        self.hover = false
    end
end

function textbox:getText()
    return self.text
end

function textbox:setText(newText)
    self.text = newText
    self.displayText = newText
    if #newText > self.size then
        self.displayText = string.sub(self.text,#newText - self.size, #newText)
    end
end


function textbox:mousepressed(x, y, button)	
	
	if self.hover then 
		self.selected = true		 
	else
		self.selected = false		
	end
	
end

function textbox:keypressed(key)	

	if string.len(self:getText()) < self.max then
	
		if self.selected then
			
			if key == "backspace" then 
	
				local str = self:getText()
						
				self:setText(string.sub(str, 1, string.len(str) - 1))			
				
			elseif key:match("[A-Za-z0-9]") then				
				local str = self:getText()
                local newKey = key
                if key ~= "return" then
                    if key == "space" then
                        newKey = " "
                        key = " "
                    elseif #key > 1 then
                        newKey = ""
                    end
                    if love.keyboard.isDown("lshift") then
                        newKey=string.upper(newKey)
                    end
				    str = str .. newKey
				    self:setText(str)
                else
                    if self.type == "TASK" then
                        self:createTask()
                    end
                end			
			end
		
		end
		
	end
end

function textbox:createTask()
    local newTask = Task.new(self:getText())
    print("created new task with name " .. newTask.name)
    table.insert(taskList,newTask)
    self:setText("")
end

return textbox
