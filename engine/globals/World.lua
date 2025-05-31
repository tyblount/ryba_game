local World = {
    entities = {},
}

function World:addEntity(e)
    table.insert(self.entities, e)
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

return World
