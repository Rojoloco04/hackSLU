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

function Task:deadline()
    local currentDateUTC = os.date("!*t")

    currentDateUTC.hour = 0
    currentDateUTC.min = 0
    currentDateUTC.sec = 0

    local deadlineUTC = os.time(currentDateUTC)

    return deadlineUTC
end

function Task:isOverdue(deadline)
    local currentTime = os.date()

    if currentTime > deadline then
        return true
    else
        return false
    end
end

--deadline system example

-- local taskDeadline = getMidnightDeadline()
-- print("Task deadline timestamp:", taskDeadline)

-- -- Check if the task is overdue

-- if isTaskOverdue(taskDeadline) then
--     print("The task is overdue!")
-- else
--     print("The task is not overdue.")
-- end
