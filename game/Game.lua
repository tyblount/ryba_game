local Game = {}

function Game.load()
    local player = Player(Pos(200, 200))
    World:addEntity(player)
end

function Game.update(dt)
    World:update(dt)
end

function Game.draw()
    World:draw()
end

return Game
