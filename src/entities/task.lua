-- src/entities/task.lua
-- Task entity representing a user task

local Constants = require("src.config.constants")
local DataService = require("src.services.dataService")
local UserManager = require("src.managers.userManager")

local Task = {}
Task.__index = Task

-- Create a new task
function Task.new(name)
    if type(name) ~= "string" or name == "" then
        error("Task name must be a non-empty string")
        return nil
    end
    
    local instance = {
        name = name,
        completed = false,
        createdAt = DataService.getCurrentDate()
    }
    
    return setmetatable(instance, Task)
end

-- Mark task as complete and give rewards
function Task:complete()
    if self.completed then
        return false, "Task already completed"
    end
    
    local data = DataService.readUserData()
    local taskIndex = nil
    
    -- Find task in user data
    for i, taskName in ipairs(data.tasks) do
        if taskName == self.name then
            taskIndex = i
            break
        end
    end
    
    -- If task found, remove it and give rewards
    if taskIndex then
        table.remove(data.tasks, taskIndex)
        self.completed = true
        DataService.writeUserData(data)

        -- Award XP and money for completing task
        UserManager.addXP(Constants.TASK_COMPLETE_XP)
        UserManager.updateMoney("add", Constants.TASK_COMPLETE_MONEY)
    else
        return false, "Task not found"
    end
end

-- Remove task without completion rewards
function Task:remove()
    local data = DataService.readUserData()
    local taskIndex = nil
    
    -- Find task in user data
    for i, taskName in ipairs(data.tasks) do
        if taskName == self.name then
            taskIndex = i
            break
        end
    end
    
    -- If task found, remove it
    if taskIndex then
        table.remove(data.tasks, taskIndex)
        return DataService.writeUserData(data)
    else
        return false, "Task not found"
    end
end

-- Check if task exists in active tasks
function Task.exists(taskName)
    local data = DataService.readUserData()
    
    for _, existingTask in ipairs(data.tasks) do
        if existingTask == taskName then
            return true
        end
    end
    
    return false
end

-- Add a task to active tasks
function Task.addToActiveTasks(task)
    if not task or not task.name then
        error("Invalid task")
        return false
    end
    
    -- Don't add if task already exists
    if Task.exists(task.name) then
        return false, "Task already exists"
    end
    
    local data = DataService.readUserData()
    table.insert(data.tasks, task.name)
    
    return DataService.writeUserData(data)
end

-- Load all tasks from user data
function Task.loadAll()
    local data = DataService.readUserData()
    local tasks = {}
    
    for _, taskName in ipairs(data.tasks) do
        local newTask = Task.new(taskName)
        table.insert(tasks, newTask)
    end
    
    return tasks
end

return Task