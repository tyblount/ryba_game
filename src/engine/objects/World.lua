World = Object:extend()

local DEFAULT_TYPE = "default"

function World:new()
    self.entities = {}
end

function World:addEntity(e, type)
    table.insert(self.entities, {
        obj = e,
        type = type or DEFAULT_TYPE,
    })
end

function World:findFirst(fn)
    local e = lume.match(self.entities, function(e)
        return fn(e.obj, e.type)
    end)
    return e and e.obj or nil
end

function World:removeAllOfType(type)
    self.entities = lume.filter(self.entities, function(e)
        return e.type ~= type
    end)
end

function World:draw()
    for _, e in ipairs(self.entities) do
        e.obj:draw()
    end
end

function World:update(dt)
    for _, e in ipairs(self.entities) do
        e.obj:update(dt)
    end
end
