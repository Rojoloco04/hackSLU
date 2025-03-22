Task = {}
Task.__index = Task
streak = 0

function Task.new(name)
    local instance = {}
    setmetatable(instance,Task)

    instance.name = name or "Unnamed task"
    instance.completed = false
    instance.deadline = Task.deadline()

    return instance
end

function Task:complete()
    self.completed = true
    print("Task " .. self.name .. " marked as completed.")
end

function Task:isAllComplete()
    local allCompleted = true
    for i=1,#taskList do 
        if taskList[i].completed ~= false or taskList[i].isOverdue() then
            allCompleted = false
            break
        end
    end

    print("all tasks completed")
    return allCompleted
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

-- NEEDS TO BE UPDATED!!!!
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

-- local taskDeadline = deadline()
-- print("Task deadline timestamp:", taskDeadline)

-- -- Check if the task is overdue

-- if isTaskOverdue(taskDeadline) then
--     print("The task is overdue!")
-- else
--     print("The task is not overdue.")
-- end

function Task:streak()
    if self.isAllComplete(taskList) == true then
        print("Ongoing")
        streak = streak + 1
    else 
        print("you are a failure")
        streak = 0
    end
end

