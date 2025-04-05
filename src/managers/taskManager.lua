-- src/managers/taskManager.lua
-- Manages task operations and UI interaction

local Constants = require("src.config.constants")
local Colors = require("src.config.colors")
local ColorUtils = require("src.utils.colorUtils")
local MathUtils = require("src.utils.mathUtils")
local Task = require("src.entities.task")
local TextBox = require("src.ui.textbox")
local DataService = require("src.services.dataService")

local TaskManager = {
    tasks = {},
    addTaskClicked = false,
    taskTextbox = nil,
    selectedTaskIndex = nil,
    defaultTasks = require("assets.data.defaultTasks"),
    
    -- Task layout parameters
    containerX = 20,
    containerY = 300,
    containerWidth = 467,
    containerHeight = 450,
    borderRadius = 15,
    
    -- Task item layout
    taskX = 30,
    taskBaseY = 310,
    taskWidth = 447,
    taskHeight = 78,
    taskGap = 10,
    
    -- Add task button
    buttonX = 465,
    buttonY = 728,
    buttonRadius = 30,
    
    -- Add task dialog
    dialogX = 27,
    dialogY = 300,
    dialogWidth = 40,
    dialogHeight = 37,
    dialogPadding = 14,
    dialogTasksGap = 40
}

-- Initialize the task manager
function TaskManager.initialize()
    -- Load tasks from user data
    TaskManager.loadTasks()
end

-- Load tasks from user data
function TaskManager.loadTasks()
    TaskManager.tasks = Task.loadAll()
end

-- Draw the task container
function TaskManager.drawTaskContainer()
    -- Draw container background
    ColorUtils.setColor(unpack(Colors.PRIMARY_DARK))
    love.graphics.rectangle(
        "fill", 
        TaskManager.containerX, 
        TaskManager.containerY, 
        TaskManager.containerWidth, 
        TaskManager.containerHeight, 
        TaskManager.borderRadius
    )
    
    -- Draw individual task items
    ColorUtils.setColor(unpack(Colors.PRIMARY_LIGHT))
    local y = TaskManager.taskBaseY
    
    for i = 1, #TaskManager.tasks do
        love.graphics.rectangle(
            "fill", 
            TaskManager.taskX, 
            y, 
            TaskManager.taskWidth, 
            TaskManager.taskHeight, 
            TaskManager.borderRadius
        )
        
        y = y + TaskManager.taskHeight + TaskManager.taskGap
    end
end

-- Draw task names
function TaskManager.drawTaskNames()
    local font = love.graphics.newFont(Constants.FONT_PATH, 30)
    love.graphics.setFont(font)
    ColorUtils.setColor(0, 0, 0)
    
    local y = TaskManager.taskBaseY + 20
    
    for i, task in ipairs(TaskManager.tasks) do
        love.graphics.print(
            task.name, 
            TaskManager.taskX + 10, 
            y
        )
        
        y = y + TaskManager.taskHeight + TaskManager.taskGap
    end
end

-- Draw the add task button
function TaskManager.drawAddButton()
    -- Draw button circle
    ColorUtils.setColor(1, 1, 1)
    love.graphics.circle(
        "fill", 
        TaskManager.buttonX, 
        TaskManager.buttonY, 
        TaskManager.buttonRadius
    )
    
    -- Draw plus sign
    ColorUtils.setColor(0, 0, 0)
    -- Vertical line
    love.graphics.rectangle(
        "fill", 
        TaskManager.buttonX - 2, 
        TaskManager.buttonY - 15, 
        5, 
        30
    )
    
    -- Horizontal line
    love.graphics.rectangle(
        "fill", 
        TaskManager.buttonX - 15, 
        TaskManager.buttonY - 3, 
        30, 
        5
    )
    
    -- Reset color
    ColorUtils.resetColor()
    
    -- Draw add task dialog if opened
    if TaskManager.addTaskClicked then
        TaskManager.drawAddTaskDialog()
    end
end

-- Draw the add task dialog
function TaskManager.drawAddTaskDialog()
    -- Draw overlay
    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle("fill", 0, 0, Constants.WINDOW_WIDTH, Constants.WINDOW_HEIGHT)
    
    -- Draw dialog background
    ColorUtils.setColor(unpack(Colors.PRIMARY_LIGHT))
    
    local boxWidth = TaskManager.taskTextbox.width + (2 * TaskManager.dialogPadding)
    local boxHeight = TaskManager.taskTextbox.height + (2 * TaskManager.dialogPadding) +
                      (#TaskManager.defaultTasks * TaskManager.dialogTasksGap)
    
    love.graphics.rectangle(
        "fill", 
        TaskManager.dialogX - TaskManager.dialogPadding, 
        TaskManager.dialogY - TaskManager.dialogPadding, 
        boxWidth, 
        boxHeight, 
        15
    )
    
    -- Draw default task options
    local font = love.graphics.newFont(Constants.FONT_PATH, 16)
    local baseY = TaskManager.dialogY + TaskManager.dialogTasksGap
    
    for i = 1, #TaskManager.defaultTasks do
        -- Draw task background
        love.graphics.setColor(1, 1, 1, 0.8)
        love.graphics.rectangle(
            "fill", 
            TaskManager.dialogX, 
            baseY, 
            TaskManager.taskTextbox.width, 
            TaskManager.taskTextbox.height, 
            15
        )
        
        -- Draw task text
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.setFont(font)
        love.graphics.print(
            TaskManager.defaultTasks[i], 
            TaskManager.dialogX + 7, 
            baseY
        )
        
        baseY = baseY + TaskManager.dialogTasksGap
    end
    
    -- Draw the textbox
    TaskManager.taskTextbox:draw()
end

-- Handle clicking on the add task button
function TaskManager.handleAddButtonClick(x, y, scale)
    local scaledButtonX = TaskManager.buttonX * scale
    local scaledButtonY = TaskManager.buttonY * scale
    local scaledButtonRadius = TaskManager.buttonRadius * scale
    
    local distance = MathUtils.distanceFromCircle(
        x, y, scaledButtonX, scaledButtonY, scaledButtonRadius
    )
    
    if distance <= scaledButtonRadius then
        if not TaskManager.addTaskClicked then
            TaskManager.addTaskClicked = true
            
            -- Create textbox if it doesn't exist
            if not TaskManager.taskTextbox then
                TaskManager.taskTextbox = TextBox.create(
                    TaskManager.dialogX * scale, 
                    TaskManager.dialogY * scale, 
                    40 * scale, 
                    37 * scale, 
                    "TASK"
                )
                
                -- Set callback for task creation
                TaskManager.taskTextbox:setOnSubmit(function(text)
                    if text and text ~= "" then
                        local newTask = Task.new(text)
                        Task.addToActiveTasks(newTask)
                        TaskManager.loadTasks()
                        TaskManager.addTaskClicked = false
                    end
                end)
            end
            
            TaskManager.taskTextbox.selected = true
        end
        
        return true
    end
    
    return false
end

-- Handle clicking on default tasks in the add task dialog
function TaskManager.handleDefaultTaskClick(x, y, scale)
    if not TaskManager.addTaskClicked or not TaskManager.taskTextbox then
        return false
    end
    
    local baseY = TaskManager.dialogY + TaskManager.dialogTasksGap
    local taskX = TaskManager.dialogX * scale
    local taskWidth = TaskManager.taskTextbox.width * scale
    local taskHeight = TaskManager.taskTextbox.height * scale
    
    for i = 1, #TaskManager.defaultTasks do
        local taskY = baseY * scale + ((i - 1) * TaskManager.dialogTasksGap * scale)
        
        if x >= taskX and x < taskX + taskWidth and
           y >= taskY and y < taskY + taskHeight then
            -- Set the textbox text to the selected default task
            TaskManager.taskTextbox:setText(TaskManager.defaultTasks[i])
            return true
        end
    end
    
    return false
end

-- Handle clicking on task items
function TaskManager.handleTaskItemClick(x, y, scale)
    if TaskManager.addTaskClicked then
        return false
    end
    
    local taskCenters = {}
    local baseY = TaskManager.taskBaseY
    
    -- Calculate center points for each task
    for i = 1, #TaskManager.tasks do
        local centerX = (TaskManager.taskX + TaskManager.taskWidth / 2) * scale
        local centerY = (baseY + TaskManager.taskHeight / 2 + 
                        (i - 1) * (TaskManager.taskHeight + TaskManager.taskGap)) * scale
        
        table.insert(taskCenters, {x = centerX, y = centerY})
    end
    
    -- Check click proximity to task centers
    local radius = (TaskManager.taskHeight / 2) * scale
    
    for i, center in ipairs(taskCenters) do
        local clicked = false
        
        -- Check a range of positions to improve hit detection
        local offsets = {0, 39, -39, 78, -78, 117, -117, 156, -156}
        for _, offset in ipairs(offsets) do
            local distance = MathUtils.distanceFromCircle(
                x, y, center.x + offset, center.y, radius
            )
            
            if distance <= radius then
                clicked = true
                break
            end
        end
        
        if clicked then
            TaskManager.selectedTaskIndex = i
            -- Mark the task as complete
            local task = TaskManager.tasks[i]
            if task then
                task:complete()
                TaskManager.loadTasks() -- Reload tasks after completing one
            end
            return true
        end
    end
    
    return false
end

-- Handle key press for the task textbox
function TaskManager.handleKeyPress(key)
    if TaskManager.addTaskClicked and TaskManager.taskTextbox then
        TaskManager.taskTextbox:keypressed(key)
        
        -- Close dialog on Enter key
        if key == "return" or key == "kpenter" then
            TaskManager.addTaskClicked = false
        end
        
        return true
    end
    
    return false
end

-- Close the add task dialog when clicking outside
function TaskManager.handleClickOutside(x, y, scale)
    if not TaskManager.addTaskClicked then
        return false
    end
    
    -- Check if clicked on default task or the textbox
    if TaskManager.handleDefaultTaskClick(x, y, scale) then
        return true
    end
    
    local boxX = (TaskManager.dialogX - TaskManager.dialogPadding) * scale
    local boxY = (TaskManager.dialogY - TaskManager.dialogPadding) * scale
    local boxWidth = (TaskManager.taskTextbox.width + (2 * TaskManager.dialogPadding)) * scale
    local boxHeight = (TaskManager.taskTextbox.height + (2 * TaskManager.dialogPadding) +
                      (#TaskManager.defaultTasks * TaskManager.dialogTasksGap)) * scale
    
    -- Close if clicked outside the dialog
    if x < boxX or x > boxX + boxWidth or
       y < boxY or y > boxY + boxHeight then
        TaskManager.addTaskClicked = false
        return true
    end
    
    return false
end

-- Draw everything related to tasks
function TaskManager.draw()
    TaskManager.drawTaskContainer()
    TaskManager.drawTaskNames()
    TaskManager.drawAddButton()
end

-- Handle mouse press
function TaskManager.mousepressed(x, y, button, scale)
    scale = scale or 1
    
    -- Check button clicks in order of priority
    return TaskManager.handleAddButtonClick(x, y, scale) or
           TaskManager.handleDefaultTaskClick(x, y, scale) or
           TaskManager.handleClickOutside(x, y, scale) or
           TaskManager.handleTaskItemClick(x, y, scale)
end

return TaskManager