FishingMinigame = Object:extend()

function FishingMinigame:new()
end

function FishingMinigame:onInteract()
    Game.changeMode(GameMode.EXPLORE)
    Game.world:removeAllOfType("Minigame")
end

function FishingMinigame:draw()
end

function FishingMinigame:update()
end
