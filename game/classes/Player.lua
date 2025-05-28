require "engine/init"

local draw = function(self)
    love.graphics.rectangle("line", self.pos.x, self.pos.y, self.size.w, self.size.h)
end

local update = function(self, dt)
    if (love.keyboard.isDown("right")) then
        self.pos.x = self.pos.x + self.v * dt
    end
    if (love.keyboard.isDown("left")) then
        self.pos.x = self.pos.x - self.v * dt
    end
    if (love.keyboard.isDown("up")) then
        self.pos.y = self.pos.y - self.v * dt
    end
    if (love.keyboard.isDown("down")) then
        self.pos.y = self.pos.y + self.v * dt
    end
end

local new = function(o)
    o = o or {}
    o = Entity.new(o)
    o.v = 200
    o.draw = draw
    o.update = update
    return o
end

local Player = {
    new = new
}

return Player
