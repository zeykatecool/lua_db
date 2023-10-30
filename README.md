# lua_db
Simple database system that uses JSON.
> You can check [examples.lua](https://github.com/zeykatecool/lua_db/blob/main/examples/examples.lua) for examples.

# Information
It uses [json.lua](https://github.com/zeykatecool/lua_db/blob/main/json.lua) for converting data to JSON or Lua Table.
This module is begginer friendly so u can use it easily.

# How to Use
> Its very easy to use.Add `db.lua` and `json.lua` to your project.After that , you can use db like this.
```lua
--[[
    package.path = package.path .. ";?.lua"
   - You should add path if lua can't find it.
  ]]--

local db = require("db")
local json = require("json")
```

# Documentation

## db.version() or db._VERSION()
- Returns the version of the db.
> Example:
```lua
local version = db.version()
print(version) -- returns version of db
```

## db.setfile(filename)
- Sets save file of db.
> Example:
```lua
local setFile = db.setfile("data.json") -- Save file is "data.json" now

setFile = db.setfile("data2.json") -- Save file is "data2.json" now
```

## db.set(key,value)
- Sets a key and value to save file.
> Example:
```lua
local Save = db.set("Key","Value") --Saves key "Key" with value "Value" in save file
```

## db.get(key)
- Gets a key from save file.
> Example:
```lua
local get = db.get("Key") --Returns ("Value")
```

