local Entity = Object:extend()

function Entity:new()
    self.components = {}
end

return Entity
