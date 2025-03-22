Task = {}
Task.__index = Task

function Task.new(name)
    local instance = {}
    setmetatable(instance,Task)

    instance.name = name or "Unnamed task"
    instance.completed = false

    return instance
end

function Task:complete()
    self.completed = true
    print("Task " .. self.name .. " marked as completed.")
end

function Task:display()
    print("Task: " .. self.name)
    local status

    if self.completed == true then 
        status = "Finished"
    elseif self.completed == false then
        status = "Not Finished"
    end
    
    print("Status: " .. status)
end