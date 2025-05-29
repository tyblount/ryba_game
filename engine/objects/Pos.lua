local Pos = Object:extend()

function Pos:new(x, y, rotation)
    self.x = x
    self.y = y
    self.rotation = rotation or 0
end

return Pos
