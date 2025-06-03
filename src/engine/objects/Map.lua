Map = Object:extend()

function Map:new(path)
    self.gameMap = sti(path)
end

function Map:draw()
    self.gameMap:drawLayer(self.gameMap.layers["Ground"])
    self.gameMap:drawLayer(self.gameMap.layers["Props"])
end

function Map:update()
end
