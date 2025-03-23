Task = {}
Task.__index = Task
streak = 0

function Task.new(name)
    local instance = {}
    setmetatable(instance,Task) 
    instance.name = name
    instance.deadline = Task.deadline()
    return instance
end

function Task:complete()
    local data = readUserData()
    for key, task in ipairs(data["tasks"]) do
        if task == self.name then
            table.remove(data["tasks"], key)
            print("Task " .. self.name .. " has been completed.")
            writeUserData(data)
            -- reward for completing task
            addXP(10)
            updateMoney("add", 5)
            return
        end
    end
    print("Task not found")
end

function Task:isAllComplete()
    local data = readUserData()
    local allCompleted = true
    if data["tasks"] ~= {} then
        return false
    end
    return true
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
    if self.isAllComplete(taskList) then
        streakUp()
    else 
        print("Streak broken")
        resetStreak()
    end
end

