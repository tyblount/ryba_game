Game = {
    world = World(),
    debug = true,
}

function Game.load()
    Game.player = Player(Pos(200, 200))
    Game.map = Map("maps/pond.lua")
    winWidth, winHeight = love.window.getMode()
    mapWidth = Game.map.gameMap.width * Game.map.gameMap.tilewidth
    mapHeight = Game.map.gameMap.height * Game.map.gameMap.tileheight
    -- Set initial camera scale so that the map overfills the window horizontally a bit.
    local initialScale = (winWidth / mapWidth) * 1.2
    Game.camera = gamera.new(0, 0, mapWidth, mapHeight)
    Game.camera:setScale(initialScale)
    Game.world:addEntity(Game.map)
    Game.world:addEntity(Game.player)
end

function Game.reset()
    Game.world = World()
    Game.load()
end

function Game.update(dt)
    if Game.debug then
        -- Scale adjustment controls
        if love.keyboard.isDown("=") or love.keyboard.isDown("+") then
            Game.camera:setScale(math.min(Game.camera:getScale() + 4 * dt, 6)) -- Max scale
        end
        if love.keyboard.isDown("-") then
            Game.camera:setScale(math.max(Game.camera:getScale() - 4 * dt, 1.0)) -- Min scale
        end
    end

    Game.world:update(dt)
    Game.camera:setPosition(Game.player.pos.x, Game.player.pos.y)
end

local function drawWithinCamera()
    Game.world:draw()
end

function Game.draw()
    Game.camera:draw(drawWithinCamera)

    if (Game.debug) then
        -- Draw scale debug info (not affected by scaling)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print("Scale: " .. string.format("%.1f", Game.camera:getScale()) .. "x (-/+)", 10, 10)
    end
end

return Game
