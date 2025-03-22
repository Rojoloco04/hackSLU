Task = {}
Task.__index = Tasks

function Task:add(name, dueDate, description)
    local instance = {}
    setmetatable(instance,Task)

    name = name or "Unnamed task"
    dueDate = dueDate or "No due date"
    description = description or "No description"
    instance.completed = false

    return instance
end


function Task:complete()
    local utils = require("level")
    self.completed = true
    print("Task " .. task.name .. " marked as completed.")

    utils.xpGain(25)
end

function Task:display()
    print("Task: " .. task.name)
    print("Due date: " .. task.date)
    print("Description: " .. task.description)
    print("Status: " .. task.completed)
end 

local task1 = Task:new("Finish project", "12/12/12", "HackSLU")