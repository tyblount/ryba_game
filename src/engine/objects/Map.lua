Map = Object:extend()

function Map:new(path)
    self.gameMap = sti(path)
end

function Map:draw()
    self.gameMap:draw()
end

function Map:update()
end
