Game = {
    world = World()
}

function Game.start()
    Game.world:addEntity(Background("assets/bg.png"))
    Game.world:addEntity(Player(Pos(200, 200)))
end

function Game.reset()
    Game.world = World()
    Game.start()
end

function Game.update(dt)
    Game.world:update(dt)
end

function Game.draw()
    Game.world:draw()
end

return Game
