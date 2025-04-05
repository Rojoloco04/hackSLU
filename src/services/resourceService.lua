-- src/services/resourceService.lua
-- Provides access to mental health resources

local resources = require("assets.data.resources")

local ResourceService = {
    -- Resources loaded from the external file
    resources = resources
}

-- Get all available resources
function ResourceService.getAllResources()
    return ResourceService.resources
end

-- Get a resource by index
function ResourceService.getResource(index)
    if index >= 1 and index <= #ResourceService.resources then
        return ResourceService.resources[index]
    end
    return nil
end

-- Get a filtered list of resources by category
function ResourceService.getResourcesByCategory(category)
    -- Implementation remains the same
end

-- Get emergency resources
function ResourceService.getEmergencyResources()
    -- Implementation remains the same
end

-- Add a custom resource
function ResourceService.addResource(resource)
    -- Implementation remains the same
end

return ResourceService