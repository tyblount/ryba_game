-- conf.lua: Love runs this file before running main.lua

function love.conf(t)
    t.title = "Ryba"           -- The title of the window
    t.version = "11.4"         -- The LÖVE version this game was made for
    t.window.width = 800       -- The window width
    t.window.height = 600      -- The window height
    t.window.resizable = false -- Let the window be resizable?

    -- For debugging
    t.console = false -- Attach a console for print statements
end
