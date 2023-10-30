local db = require("dbforexamples")

--[[
    db.version() or db._VERSION()
    ⸻⸻⸻⸻⸻⸻
    returns version of db when printed
]]

local Version = db.version() or db._VERSION() -- Returns version of db

--[[
    db.setfile(filename)
    ⸻⸻⸻⸻⸻⸻
    returns error when filename is nil
    ⸻⸻⸻⸻⸻⸻
    returns error when file is not json
    ⸻⸻⸻⸻⸻⸻
    creates new json file when file cannot found
    ⸻⸻⸻⸻⸻⸻
    returns ("successfully set file to " .. filename) when printed
]]

local setFile = db.setfile("data") -- Save file is data.json now

setFile = db.setfile("data2") -- Save file is data2.json now

--[[
    db.set(key,value)
    ⸻⸻⸻⸻⸻⸻
    returns error when key is not string
    returns error when value is not any
    ⸻⸻⸻⸻⸻⸻
    saves value to key in save file
    ⸻⸻⸻⸻⸻⸻
    returns ("successfully saved " .. key .. " to " .. tostring(value) .. " in " .. filename) when printed
]]

local Save = db.set("Key","Value") --Saves key "Key" with value "Value" in save file

--[[
    db.get(key)
    ⸻⸻⸻⸻⸻⸻
    returns error when key is not string
    ⸻⸻⸻⸻⸻⸻
    gets value from key in save file
    ⸻⸻⸻⸻⸻⸻
    returns value when printed
]]

local Get = db.get("Key") --Returns ("Value")

--[[
    db.change(key,value)
    ⸻⸻⸻⸻⸻⸻
    returns error when key is not string
    ⸻⸻⸻⸻⸻⸻
    returns error when value is not any
    ⸻⸻⸻⸻⸻⸻
    changes value of key in save file
    ⸻⸻⸻⸻⸻⸻
    returns ("successfully saved " .. key .. " to " .. tostring(value) .. " in " .. filename) when printed
]]

local Change = db.change("Key","Value2") --Changes key "Key" with value "Value2" in save file

--[[
    db.delete(key)
    ⸻⸻⸻⸻⸻⸻
    returns error when key is not string
    ⸻⸻⸻⸻⸻⸻
    deletes key from save file
    ⸻⸻⸻⸻⸻⸻
    works like db.deleteall() when key is db.all()
    ⸻⸻⸻⸻⸻⸻
    returns ("successfully deleted " .. key) when printed
]]

local Delete = db.delete("Key") --Deletes key "Key" from save file

--[[
    db.deleteall(returnallbeforedelete)
    ⸻⸻⸻⸻⸻⸻
    sets returnallbeforedelete to false by default
    ⸻⸻⸻⸻⸻⸻
    deletes all keys from save file
    ⸻⸻⸻⸻⸻⸻
    returns ("successfully deleted all keys") when printed
    ⸻⸻⸻⸻⸻⸻
    returns db.all() when returnallbeforedelete is true
]]

local DeleteAll = db.deleteall(false) --Deletes all keys from save file
local DeleteAll_ReturnBeforeDelete = db.deleteall(true) --Deletes all keys from save file , returns db.all()

--[[
    db.all(table_or_string)
    ⸻⸻⸻⸻⸻⸻
    sets table_or_string to table by default
    ⸻⸻⸻⸻⸻⸻
    returns all as table when table_or_string is table
    ⸻⸻⸻⸻⸻⸻
    returns all as string (JSON) when table_or_string is string
]]

local All = db.all() --Returns all as table
local All_JSON = db.all("string") --Returns all as string (JSON)

--[[
    db.size(key)
    ⸻⸻⸻⸻⸻⸻
    returns error when key is not string
    ⸻⸻⸻⸻⸻⸻
    return type : number (byte)
    ⸻⸻⸻⸻⸻⸻
    returns size of key in save file
    ⸻⸻⸻⸻⸻⸻
    returns size when printed
]]

local Size = db.size("Key") --Returns size of value "Key" in save file

--[[
    db.sizeall()
    ⸻⸻⸻⸻⸻⸻
    returns type : number (byte)
    ⸻⸻⸻⸻⸻⸻
    returns size of all keys in save file
]]

local SizeAll = db.sizeall() --Returns size of all keys in save file

--[[
    db.similiar(any,keyorarray)
    ⸻⸻⸻⸻⸻⸻
    returns error when keyorarray is not string
    ⸻⸻⸻⸻⸻⸻
    returns error when any is not any
    ⸻⸻⸻⸻⸻⸻
    returns empty table if not found similiar 
    ⸻⸻⸻⸻⸻⸻
    returns table when found similiar
    ⸻⸻⸻⸻⸻⸻
    keyorarray dont have default, you have to set it
    ⸻⸻⸻⸻⸻⸻
    returns table when printed
]]

local FindSimiliarKey = db.similiar("string","key") --Returns all string values in save file
--[[
    db.set("MyVal","StringVal1")
    db.set("MyVal2","StringVal2")

    print(db.similiar("string","key")) --returns ; {MyVal = "StringVal1", MyVal2 = "StringVal2"}
]]

local FindSimiliarArray = db.similiar("string","array") --Returns all string values in save file
--[[
    db.set("MyVal","StringVal1")
    db.set("MyVal2","StringVal2")

    print(db.similiar("string","key")) --returns ; {1 = "StringVal1", 2 = "StringVal2"}
]]

--[[
    db.setwithdate(key, value)
    ⸻⸻⸻⸻⸻⸻
    returns error when key is not string
    ⸻⸻⸻⸻⸻⸻
    returns error when value is not any
    ⸻⸻⸻⸻⸻⸻
    saves value to key in save file with date,as table
    type : os.date("%d.%m.%Y,%H:%M:%S")
    ⸻⸻⸻⸻⸻⸻
    returns ("successfully saved ,with date, " .. key .. " to " .. tostring(value) .. " in " .. filename) when printed
]]

local SetWithDate = db.setwithdate("Key","Value") --Saves key "Key" with value "Value" in save file with date
--[[
    - dateofsave is example
   saved {value = "Value", dateofsave = "01.01.2020,00:00:00"}
]]

--[[
    db.getwithdate(key)
    ⸻⸻⸻⸻⸻⸻
    returns error when key is not string
    ⸻⸻⸻⸻⸻⸻
    returns error when key does not exist
    ⸻⸻⸻⸻⸻⸻
    returns error when key dont have date of save
    ⸻⸻⸻⸻⸻⸻
    returns value and date when printed,not table
]]

local GetWithDate = db.getwithdate("Key") --Returns value "Value" and date "01.01.2020,00:00:00" of key "Key" in save file
--[[
    Usage:
    local value,date = db.getwithdate("Key")
]]

--[[
    Importants:
   - You cannot get date of save with db.get() , it returns only value of key
    Usage:
   db.setwithdate("Key","Value")
   db.get("Key") --returns ("Value")
   db.getwithdate("Key") -- Returns "Value","01.01.2020,00:00:00"
   ⸻⸻⸻⸻⸻⸻
   - You can save functions,it uses string.dump() for save
   db.set("MyFunction",function() print("Hello World") end)
   db.get("MyFunction") -- returns function
     Usage:
    local f = load(db.get("MyFunction"))
    f()
]]
