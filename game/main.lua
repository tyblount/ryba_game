require "engine/init"
require "game/classes/init"

love.load = function()
    local player = Player.new({ pos = Pos.new(200, 200), size = Size.new(50, 100) })
    World:addEntity(player)
end

love.update = function(dt)
    World:update(dt)
end

love.draw = function()
    World:draw()
end
