Task = {}
Task.__index = Task

function Task.new(name)
    local instance = {}
    setmetatable(instance,Task) 
    instance.name = name
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
            addXP(100)
            updateMoney("add", 5)
            return
        end
    end
    print("Task not found")
end