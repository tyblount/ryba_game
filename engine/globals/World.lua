local world = {
    entities = {},
}

function world:addEntity(e)
    table.insert(self.entities, e)
end

function world:draw()
    for _, e in ipairs(self.entities) do
        e:draw()
    end
end

function world:update(dt)
    for _, e in ipairs(self.entities) do
        e:update(dt)
    end
end

return world
