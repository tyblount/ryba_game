local World = {
    entities = {},
    addEntity = function(self, e)
        table.insert(self.entities, e)
    end,
    draw = function(self)
        for _, e in ipairs(self.entities) do
            e:draw()
        end
    end,
    update = function(self, dt)
        for _, e in ipairs(self.entities) do
            e:update(dt)
        end
    end
}

return World
