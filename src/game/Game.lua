Game = {
    world = World(),
    scale = 1, -- Global scale factor
    debug = false,
}

function Game.load()
    local map = Map("maps/pond.lua")
    winWidth = love.window.getMode()
    mapWidth = map.gameMap.width * map.gameMap.tilewidth
    -- Set initial game scale so that the map fills the window horizontally.
    Game.scale = winWidth / mapWidth
    Game.world:addEntity(map)
    Game.world:addEntity(Player(Pos(200, 200)))
end

function Game.reset()
    Game.world = World()
    Game.load()
end

function Game.update(dt)
    if Game.debug then
        -- Scale adjustment controls
        if love.keyboard.isDown("=") or love.keyboard.isDown("+") then
            Game.scale = math.min(Game.scale + 2 * dt, 4) -- Max scale
        end
        if love.keyboard.isDown("-") then
            Game.scale = math.max(Game.scale - 2 * dt, 1.0) -- Min scale
        end
    end

    Game.world:update(dt)
end

function Game.draw()
    love.graphics.push()
    love.graphics.scale(Game.scale, Game.scale)
    Game.world:draw()
    love.graphics.pop()

    if (Game.debug) then
        -- Draw scale debug info (not affected by scaling)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print("Scale: " .. string.format("%.1f", Game.scale) .. "x (Use +/- to adjust)", 10, 10)
    end
end

return Game
