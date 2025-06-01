local Background = Object:extend()

function Background:new(path)
    self.image = love.graphics.newImage(path)
    self.pos = Pos(0, 0)
end

function Background:draw()
    love.graphics.draw(self.image, self.pos.x, self.pos.y)
end

function Background:update()
end

return Background
