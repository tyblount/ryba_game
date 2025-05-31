local Player = Object:extend()

MOVE_SPEED = 200

function Player:new(pos)
    self.pos = pos
    self.size = Size(50, 100)
end

function Player:draw()
    love.graphics.rectangle("line", self.pos.x, self.pos.y, self.size.w, self.size.h)
end

function Player:update(dt)
    if (love.keyboard.isDown("f")) then
        self.pos.x = self.pos.x + MOVE_SPEED * dt
    end
    if (love.keyboard.isDown("s")) then
        self.pos.x = self.pos.x - MOVE_SPEED * dt
    end
    if (love.keyboard.isDown("e")) then
        self.pos.y = self.pos.y - MOVE_SPEED * dt
    end
    if (love.keyboard.isDown("d")) then
        self.pos.y = self.pos.y + MOVE_SPEED * dt
    end
end

return Player
