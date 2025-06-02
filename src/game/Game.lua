Game = {
    world = World()
}

function Game.load()
    Game.world:addEntity(Map("maps/pond.lua"))
    Game.world:addEntity(Player(Pos(200, 200)))
end

function Game.reset()
    Game.world = World()
    Game.load()
end

function Game.update(dt)
    Game.world:update(dt)
end

function Game.draw()
    Game.world:draw()
end

return Game
