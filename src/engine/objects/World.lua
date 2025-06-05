World = Object:extend()

function World:new()
    self.entities = {}
    self.byType = {}
end

function World:addEntity(e, type)
    table.insert(self.entities, e)
    if type then
        if not self.byType[type] then
            self.byType[type] = {}
        end
        table.insert(self.byType[type], e)
    end
end

function World:findAll(fn, type)
    local matches = {}
    for _, obj in ipairs(self.byType[type] or {}) do
        if fn(obj) then
            table.insert(matches, obj)
        end
    end
    return matches
end

function World:findFirst(fn, type)
    local matches = self:findAll(fn, type)
    return matches[1]
end

function World:draw()
    for _, e in ipairs(self.entities) do
        e:draw()
    end
end

function World:update(dt)
    for _, e in ipairs(self.entities) do
        e:update(dt)
    end
end
