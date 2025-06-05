GameMode = {
    EXPLORE = 1,
    CHAT = 2,
    FISH = 3,
}

Game = {
    debug = false,
}

function Game.load()
    Game.world = World()
    Game.phys = wf.newWorld(0, 0)
    Game.map = Map("maps/pond.lua")
    Game.camera = gamera.new(0, 0, Game.map.width, Game.map.height)
    Game.player = Player(Pos(200, 200))
    Game.minigame = nil
    Game.mode = GameMode.EXPLORE
    Game.world:addEntity(Game.map)
    Game.world:addEntity(Game.player)
    Game.world:addEntity(NPC(Pos(110, 210)), "Interactable")

    -- Set initial camera scale so that the map overfills the window horizontally a bit.
    winWidth, _ = love.window.getMode()
    local initialScale = (winWidth / Game.map.width) * 1.2
    Game.camera:setScale(initialScale)
end

function Game.reset()
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
    Game.phys:update(dt)
    Game.camera:setPosition(Game.player.pos.x, Game.player.pos.y)
end

local function drawWithinCamera()
    Game.world:draw()
    if (Game.debug) then
        Game.phys:draw()
    end
end

function Game.draw()
    Game.camera:draw(drawWithinCamera)

    if (Game.debug) then
        -- Draw scale debug info (not affected by scaling)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print("Scale: " .. string.format("%.1f", Game.camera:getScale()) .. "x (-/+)", 10, 10)
    end
end

function Game.changeMode(gameMode)
    Game.mode = gameMode
end

return Game
