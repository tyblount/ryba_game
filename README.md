# ryba_
2d Fishing Simulator via Lua


## Development Setup

### Run
From the root directory, run `love game`

### Repo Organization
```
<root>
  engine/     -- ryba-agnostic stuff that could be potentially re-used in another game
  game/       -- ryba-specific stuff that makes use of the stuff in engine/
  lib/        -- third-party stuff that shouldn't be checked in
```

### Löve2D
We're using the Löve2D framework to help make the more technical parts of game development easier.
Follow the installation instructions here: https://love2d.org/wiki/Getting_Started

### Live Reload
It's a chore to have to quit the game and restart it whenever you make any changes.
The LICK package aims to reload changes while the game is running.

It overrides the `love.run` function, so this needs to be installed to get the game to run.
Download the ZIP from the releases page:
https://github.com/usysrc/LICK/releases/tag/v1.0.0

Unzip the ZIP and copy the `lick.lua` file to `/lib/lick.lua`.

TODO: The process of downloading dependencies should probably be automated somehow.

### OOP
We're using `classic` to implement Object-Oriented Programming in Lua.

Copy the file from GitHub to `/lib/classic.lua`:
https://github.com/rxi/classic/blob/master/classic.lua

Using OOP certainly isn't a requirement for game dev in Lua,
but it's familiar which has value on its own.
Also, letting instances reference methods on classes via metatable lookups
rather than with closures works better with Live Reloading.


### Formatting with Prettier
Prettier is a code formatter that helps maintain consistent code style across your project.
It makes styling decisions for you (and your team) so that you don't have to spend time on it.

Follow the installation instructions for your editor here:
https://prettier.io/docs/install

### Lua Language Server
The Lua Language Server (LLS) makes coding with Lua in an editor a lot easier.
It provides a bunch of features like code completion, error checking, and documentation lookup.
https://luals.github.io/#features

Follow the installation instructions for your editor here:
https://luals.github.io/#vscode-install

#### Configuration
Configuration for LLS is defined in `.luarc.json`

#### Install the Löve LLS Addon
To get editor support for Löve, first we need to install the LLS Addon.
Open this link, then follow the `module` link and download the code there as a ZIP:
https://github.com/LuaLS/LLS-Addons/tree/main/addons/love2d

Unzip that code underneath `./lib/types` and rename it to `love2d`.
Now, the LLS will be able to find type definitions at `./lib/types/love2d`, as defined in `.luarc.json`.


## References
Here are some resources that have been helpful so far:

- [Game Programming Patterns](https://gameprogrammingpatterns.com/contents.html)
- [How to Löve](https://sheepolution.com/learn/book/contents)
