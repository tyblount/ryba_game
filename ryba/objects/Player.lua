local Player = Object:extend()

function Player:new(pos)
    self.pos = pos
    self.size = Size(50, 100)
    self.v = 200
end

function Player:draw()
    love.graphics.rectangle("line", self.pos.x, self.pos.y, self.size.w, self.size.h)
end

function Player:update(dt)
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

return Player
