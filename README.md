# lua_db
- Simple database system that uses JSON.

# Information
- It uses [json.lua](https://github.com/zeykatecool/lua_db/blob/main/json.lua) for converting data to JSON or Lua Table.
- This module is beginner friendly so u can use it easily.

# How to Use
- Its very easy to use.Add `db.lua` and `json.lua` to your project.After that , you can use db like this.
```lua
--[[
    package.path = package.path .. ";?.lua"
   - You should add path if lua can't find it.
  ]]--

local db = require("db")
local setFile = db.setfile("data")

```
# Download
```git
git clone https://github.com/zeykatecool/lua_db.git
```

# Documentation
> Documentation is here with examples :
- [documentation.lua](https://github.com/zeykatecool/lua_db/blob/main/info/documentation.lua)

