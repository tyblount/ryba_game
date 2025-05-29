-- main.lua: Love runs this file as the entrypoint for the game.
love.load = function()
    local player = Player(Pos(200, 200))
    World:addEntity(player)
end

love.update = function(dt)
    World:update(dt)
end

love.draw = function()
    World:draw()
end
