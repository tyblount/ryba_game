require "engine/classes/init"
require "engine/globals/init"

local lick = require "lib/lick/lick"
lick.reset = true              -- call love.load() on every reload?
lick.showReloadMessage = false -- print a console log on every reload?
