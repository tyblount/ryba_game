local Game = {}

function Game.load()
    World:addEntity(Background("assets/bg.png"))
    World:addEntity(Player(Pos(200, 200)))
end

function Game.update(dt)
    World:update(dt)
end

function Game.draw()
    World:draw()
end

return Game
