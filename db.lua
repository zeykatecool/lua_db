local db = {}
local json = require("json")
local filename = nil
local function getFileSize(filePath)
    local file = io.open(filePath, "r")
    if file then
        local fileSize = file:seek("end")
        file:close()
        return fileSize
    else
        return "File not found"
    end
end
local function createFile(filename)
    local file = io.open(filename, "w")
    if file then
        io.close(file)
        print(filename .. " created successfully.")
    else
        print("Could not create " .. filename)
    end
end
local function toJSON(table, ...)
    if not table then
        return error("expected argument of type table, got " .. type(table))
    end

    if type(table) ~= "table" then
        return error("expected argument of type table, got " .. type(table))
    end
    return json.encode(table)
end

function toLuaTable(str, ...)
    if not str then
        return error("expected argument of type string, got " .. type(str))
    end
    if type(str) ~= "string" then
        return error("expected argument of type string, got " .. type(str))
    end
    return json.decode(str)
end

function writeToFile(filename, content)
    local file = io.open(filename, "w")
    if file then
        file:write(content)
        io.close(file)
    else
        return error("some error occured while writing to file")
    end
end

function readFile(filename)
    local file = io.open(filename, "r")
    if file then
        local content = file:read("*all")
        io.close(file)
        return content
    else
        return "Could not read " .. filename
    end
end

local function checkJSONExtension(filename)
    local extension = filename:sub(-5)
    if extension == ".json" then
        return true
    else
        return false
    end
end

local function isFileEmpty(filename)
    local file = io.open(filename, "r")

    if file then
        local size = file:seek("end")
        io.close(file)

        if size == 0 then
            return true
        else
            return false
        end
    else
        return "File does not exist"
    end
end

function db.setfile(str)
    if not str then
        return error("expected argument of type string, got " .. type(str))
    end
    if type(str) ~= "string" then
        return error("expected argument of type string, got " .. type(str))
    end

    if string.find(str, "%.") then
    else
        str = str .. ".json"
    end

    local isexits = io.open(str, "r")
    if not isexits then
        ext = checkJSONExtension(str)
        if ext == true then
        else
            return error("file is not json,file does not exits")
        end
        print("file does not exist,creating the file " .. str)
        filename = str
        createFile(str)
        writeToFile(str, "{}")
        return "successfully created file " .. str .. " and set file"
    end
    if isexits then
        ext = checkJSONExtension(str)
        if ext == true then
            filename = str
            if isFileEmpty(str) then
                writeToFile(str, "{}")
            end
            return "successfully set file to " .. filename
        else
            return error("file is not json")
        end
    end
end

local function stringifyFunction(func)
    local dumped = string.dump(func)
    return dumped
end

local function loadFunction(dumped)
    local loaded = load(dumped)
    return loaded
end

local function isDumpedString(str)
    local success, result = pcall(load, str)
    return success and type(result) == "function"
end

function db.get(key)
    if not key then
        return error("expected argument of type string, got " .. type(key))
    end
    if type(key) ~= "string" then
        return error("expected argument of type string, got " .. type(key))
    end

    local readit = readFile(filename)
    local toluatable = toLuaTable(readit)
    local value = toluatable[key]

    if isDumpedString(value) then
        if type(loadFunction(value)) == "function" then
            return value
        end
    end

    return toluatable[key]
end

local function stringifyFunction(func)
    local dumped = string.dump(func)
    return dumped
end

function db.set(key, value)
    if filename == nil then
        return error("filename not set")
    end
    if not key then
        return error("expected argument of type string, got " .. type(key))
    end
    if not value then
        return error("expected argument of type any, got " .. type(value))
    end

    if type(value) == "function" then
        value = stringifyFunction(value)
        local readit = readFile(filename)
        local jsontoluatable = toLuaTable(readit)
        jsontoluatable[key] = value
        local newtable = toJSON(jsontoluatable)
        writeToFile(filename, newtable)

        return "successfully saved " .. key .. " to " .. tostring(value) .. " in " .. filename
    end

    if type(key) ~= "string" then
        return error("expected argument of type string, got " .. type(key))
    end

    if db.get(key) then
        return error("key already exists")
    end

    local readit = readFile(filename)
    local jsontoluatable = toLuaTable(readit)
    jsontoluatable[key] = value
    local newtable = toJSON(jsontoluatable)
    writeToFile(filename, newtable)

    return "successfully saved " .. key .. " to " .. tostring(value) .. " in " .. filename
end

function db.delete(key)
    if type(key) == "table" then
        for keyk, keyv in pairs(key) do
            for allk, allv in pairs(db.all()) do
                if keyk == allk then
                    if keyv == allv then
                        db.deleteall()
                        return "successfully deleted all keys"
                    end
                end
            end
        end
    end
    if filename == nil then
        return error("filename not set")
    end
    if not key then
        return error("expected argument of type string, got " .. type(key))
    end
    if type(key) ~= "string" then
        return error("expected argument of type string, got " .. type(key))
    end
    if db.get(key) then
    else
        return error("key does not exist")
    end

    local readit = readFile(filename)
    local toluatable = toLuaTable(readit)
    toluatable[key] = nil
    local newtable = toJSON(toluatable)
    writeToFile(filename, newtable)

    return "successfully deleted " .. key
end

function db.deleteall(returnallbeforedelete)
    if returnallbeforedelete == nil then
        returnallbeforedelete = false
    end
    local readit = readFile(filename)

    local toluatable = toLuaTable(readit)
    local returnbeforedelete = toluatable

    toluatable = {}
    local newtable = toJSON(toluatable)
    writeToFile(filename, newtable)
    if returnallbeforedelete then
        return returnbeforedelete
    end
    return "successfully deleted all keys"
end

function db.change(key, value)
    if filename == nil then
        return error("filename not set")
    end

    if not key then
        return error("expected argument of type string, got " .. type(key))
    end
    if not value then
        return error("expected argument of type any, got " .. type(value))
    end

    if type(key) ~= "string" then
        return error("expected argument of type string, got " .. type(key))
    end

    --check if value is function
    if type(value) == "function" then
        value = stringifyFunction(value)
        local readit = readFile(filename)
        local jsontoluatable = toLuaTable(readit)
        jsontoluatable[key] = value
        local newtable = toJSON(jsontoluatable)
        writeToFile(filename, newtable)

        return "successfully saved " .. key .. " to " .. tostring(value) .. " in " .. filename
    end

    local readit = readFile(filename)
    local toluatable = toLuaTable(readit)

    if toluatable[key].dateofsave then
        toluatable[key].value = value
        toluatable[key].dateofchanged = os.date("%d.%m.%Y,%H:%M:%S")
    else
        toluatable[key] = value
    end

    local newtable = toJSON(toluatable)

    writeToFile(filename, newtable)
    return "successfully changed " .. key .. " to " .. value
end

function db.size(key)
    if filename == nil then
        return error("filename not set")
    end
    if not key then
        return error("expected argument of type string, got " .. type(key))
    end
    if type(key) ~= "string" then
        return error("expected argument of type string, got " .. type(key))
    end
    local readit = readFile(filename)
    local toluatable = toLuaTable(readit)
    local gettingsize = toluatable[key]
    if type(gettingsize) == "table" then
        return #toJSON(gettingsize)
    end
end

function db.sizeall()
    if filename == nil then
        return error("filename not set")
    end
    return getFileSize(filename)
end

function db.all(table_or_string)
    if filename == nil then
        return error("filename not set")
    end
    if not table_or_string then
        table_or_string = "table"
    end
    if table_or_string == "table" then
        local readit = readFile(filename)
        local toluatable = toLuaTable(readit)
        return toluatable
    elseif table_or_string == "string" then
        local readit = readFile(filename)
        return readit
    else
        return error("expected argument of type string or table or nil, got " .. table_or_string)
    end
end

function db.version()
    return "version 0.1"
end

local function tablelength(tablehere)
    if filename == nil then
        return error("filename not set")
    end
    local count = 0
    for _ in pairs(tablehere) do
        count = count + 1
    end
    return count
end

function db.similiar(any, keyorarray)
    if filename == nil then
        return error("filename not set")
    end
    if type(any) == "boolean" then
    else
        if not any then
            return error("expected argument of type any, got " .. type(any))
        end
    end
    if not keyorarray then
        return error("expected argument of type string, got " .. type(keyorarray))
    end
    if keyorarray == "key" then
    elseif keyorarray == "array" then
    else
        return error("expected argument key or array of type string, got " .. type(keyorarray))
    end

    if any then
        local readfile = readFile(filename)
        local toluatable = toLuaTable(readfile)
        local returningtable = {}
        for k, v in pairs(toluatable) do
            if type(v) == any then
                if keyorarray == "array" then
                    table.insert(returningtable, v)
                elseif keyorarray == "key" then
                    returningtable[k] = v
                end
            end
        end
        if tablelength(returningtable) == 0 then
            return {}
        end
        return returningtable
    end
end

function db.setwithdate(key, value)
    if filename == nil then
        return error("filename not set")
    end
    if not key then
        return error("expected argument of type string, got " .. type(key))
    end
    if not value then
        return error("expected argument of type any, got " .. type(value))
    end

    local readit = readFile(filename)
    local toluatable = toLuaTable(readit)
    local date = os.date("%d.%m.%Y,%H:%M:%S")
    toluatable[key] = {value = value, dateofsave = date}
    local newtable = toJSON(toluatable)
    writeToFile(filename, newtable)

    return "successfully saved ,with date, " .. key .. " to " .. tostring(value) .. " in " .. filename
end

function db.getwithdate(key)
    if filename == nil then
        return error("filename not set")
    end
    if not key then
        return error("expected argument of type string, got " .. type(key))
    end

    if db.get(key) then
    else
        return error("key does not exist")
    end

    local readit = readFile(filename)
    local toluatable = toLuaTable(readit)
    if toluatable[key].dateofsave then
    else
        return error("this save dont have date of save")
    end
    local value = toluatable[key].value
    local date = toluatable[key].dateofsave

    return value, date
end

db._VERSION = "version 0.1"

return db
