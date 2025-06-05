World = Object:extend()

local DEFAULT_TYPE = "default"

function World:new()
    self.byType = {}
end

function World:addEntity(e, type)
    type = type or DEFAULT_TYPE
    if not self.byType[type] then
        self.byType[type] = {}
    end
    table.insert(self.byType[type], e)
end

function World:findAll(fn, type)
    type = type or DEFAULT_TYPE
    local matches = {}
    if fn then
        for _, obj in ipairs(self.byType[type] or {}) do
            if fn(obj) then
                table.insert(matches, obj)
            end
        end
    elseif type then
        matches = self.byType[type] or {}
    end
    return matches
end

function World:findFirst(fn, type)
    local matches = self:findAll(fn, type)
    return matches[1]
end

function World:removeAllOfType(type)
    local removed = self.byType[type]
    self.byType[type] = nil
    return removed
end

function World:draw()
    for _, entities in pairs(self.byType) do
        for _, e in ipairs(entities) do
            e:draw()
        end
    end
end

function World:update(dt)
    for _, entities in pairs(self.byType) do
        for _, e in ipairs(entities) do
            e:update(dt)
        end
    end
end
