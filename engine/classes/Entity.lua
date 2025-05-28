local Pos = require "engine/classes/Pos"
local Size = require "engine/classes/Size"

local draw = function()
    error("NotImplementedError: Entity.draw()", 2)
end

local update = function()
    error("NotImplementedError: Entity.update()", 2)
end

local new = function(o)
    o = o or {}
    o.pos = o.pos or Pos.new(0, 0)
    o.size = o.size or Size.new(0, 0)
    o.draw = o.draw or draw
    o.update = o.update or update
    return o
end

local Entity = {
    new = new
}

return Entity
