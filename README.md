# ryba_
2d Fishing Simulator via Lua

## Development Setup

### Run
From the root directory, run
```sh
$ love .
```

### Repo Organization
```
<root>
  assets/     -- sprites, backgrounds, sounds, etc.
  lib/        -- third-party stuff that shouldn't be checked in
  src/        -- the majority of the code we're writing lives here
    engine/   -- code that isn't ryba-specific and could be re-used in another game
    game/     -- code specifically for the ryba game
  conf.lua    -- special file that love runs before main.lua
  main.lua    -- special file that love runs to start the game
```

### Löve2D
We're using the Löve2D framework to help make the more technical parts of game development easier.
It's hard to type the o-with-umlaut 'ö' so it may just be referred to as 'love' elsewhere.
Follow the [installation instructions](https://love2d.org/wiki/Getting_Started) to install it for your platform.

### Sprite Animation
Using `anim8` library to lookup animation frames in sprite sheets and animate those frames.
Download/copy the file from GitHub to `lib/` (e.g. `lib/anim8.lua`)
- [anim8.lua](https://github.com/kikito/anim8/blob/bd38defa844ab2dfa3bf416a10c45ce376ba4c50/anim8.lua)

### Maps and Tilesets
Using `Tiled` to create tilemaps and tilesets, which can be downloaded from the website:
- https://www.mapeditor.org/download.html

And then we're using `Simple-Tiled-Implementation` to load in the map data and render it
using love.

Download the ZIP from GitHub, and copy just the `sti` folder into `lib/`
- [Simple-Tiled-Implementation](https://github.com/karai17/Simple-Tiled-Implementation/tree/master)

### Live Reload
It's a chore to have to quit the game and restart it whenever you make any changes.
The `lurker` package aims to reload changes while the game is running.
It also relies on `lume`, which is a library of Lua helper functions written by the
same developer, [rxi](http://github.com/rxi), aimed at game development.

Download/copy from GitHub to `lib/`
- [lume.lua](https://github.com/rxi/lume/blob/98847e7812cf28d3d64b289b03fad71dc704547d/lume.lua)
- [lurker.lua](https://github.com/rxi/lurker/blob/03d1373911f586c1c6d5d557527b5d510190fd94/lurker.lua)

TODO: The process of downloading dependencies should probably be automated somehow.

### OOP
We're using `classic` to implement Object-Oriented Programming in Lua.

Download/copy from GitHub to `lib/classic.lua`:
- [classic.lua](https://github.com/rxi/classic/blob/e5610756c98ac2f8facd7ab90c94e1a097ecd2c6/classic.lua)

Using OOP certainly isn't a requirement for game dev in Lua, but it's familiar which has value on its own.
Plus, letting instances reference methods and fields on classes via metatable lookups
rather than maintaining references with closures better enables live reloading.

### Formatting with Prettier
Prettier is a code formatter that helps maintain consistent code style across your project.
It makes styling decisions for you (and your team) so that you don't have to spend time on it.

Follow the [installation instructions](https://prettier.io/docs/install) for your editor of choice.

### Lua Language Server
The Lua Language Server (LLS) makes coding with Lua in an editor a lot easier.
It provides [a bunch of features](https://luals.github.io/#features) like code completion, error checking, and documentation lookup.

Follow the [installation instructions](https://luals.github.io/#vscode-install) for your editor of choice.

#### Configuration
Configuration for LLS is defined in `.luarc.json`

#### Install the Löve LLS Addon
To get editor support for Löve, first we need to install the LLS Addon.
Follow this link and download the code there as a ZIP:
- [Love2D LLS Addon](https://github.com/LuaCATS/love2d/tree/97fa46cd694e09f953157a5c71e7e9adeb99d0c8)

Unzip the file you just downloaded, place it in `lib/types`, and rename it to `love2d`.
Now, the LLS will be able to find type definitions at `lib/types/love2d`, as defined in `.luarc.json`.

## References
Here are some resources that have been helpful so far:

- [Game Programming Patterns by Robert Nystrom](https://gameprogrammingpatterns.com/contents.html)
- [Love2D Basics on YT by Challacade](https://www.youtube.com/playlist?list=PLqPLyUreLV8DrLcLvQQ64Uz_h_JGLgGg2)
- [How to Löve by Sheepolution](https://sheepolution.com/learn/book/contents)
