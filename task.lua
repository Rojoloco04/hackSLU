Task = {}
Task.__index = Task

function Task:new(name)
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
    print("Status: " .. tostring(self.completed))
end 

local task1 = Task:new("Finish project")

task1:display()
task1:complete()
task1:display()