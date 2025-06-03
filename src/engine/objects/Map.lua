Map = Object:extend()

function Map:new(path)
    self.gameMap = sti(path)
end

function Map:draw()
    self.gameMap:draw(0, 0, Game.scale)
end

function Map:update()
end
