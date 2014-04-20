--[[
Pure Lua archiver made by Andy73 a.k.a. viluon

Copyright 2014
version 0.31 BETA (3rd public release)

usage: archiver <compress|extract|help> <file input path> <file output path>

FUNCTIONAL!!!
]]

local s=48

local function help()
print("Pure Lua archiver by Andy a.k.a. viluon copyright 2014")
print("version 0.3 BETA")
print("")
print("Current dictionary size: "..s.." keywords")
print("")
print("Please note:Beta versions can cause unexpected data changes. Andy is not responsible for any data corruption or removals caused by this program. Use at your own risk.")
end

local function usage()
print("Usage:")
print(" archiver <compress|extract|help> <file input path> <file output path>")
print("'compress','extract' or 'help' can be shortened to 'c','e' or '?'")
end

local tArgs={...}

local t=nil

local function r(a,b)
t=string.gsub(t,a,b)
end

--COMPRESS
local function compress(...)
local args={...}--ARGS ARE SOLVED BEFORE!!!
local file=fs.open(shell.resolve(tostring(args[1])),"r")
print("FileSize original:"..fs.getSize(shell.resolve(tostring(args[1])))) print("asd")
if file then t=file.readAll() else error("Can't open:Requested source file doesn't exist.") end
file:close()
--FIRST ROUND SYMBOL @ (12x)
r("true","@ě") --new format
r("false","@š")
r("setTextScale","@č")
r("setBackgroundColor","@ř")
r("os.loadAPI","@ž")
r("color","@ý")
r("setTextColor","@á")
r("text","@í")
r("Text","@é")
r("write","@ú")
r("elseif","@ů")
r("local","@ˇ")
r("function","@´")
--SECOND ROUND SYMBOL # (12x)
r("then","#ě")
r("end","#š")
r("else","#č")
r("tostring%(","#ř")
r("tonumber%(","#ž")
r("string","#ý")
r("math","#á")
r("=os.pullEventRaw%(","#í")
r("=os.pullEvent%(","#é")
r("= os.pullEventRaw%(","#ú")
r("= os.pullEvent%(","#ů")
r("window","#ˇ")
r("process","#´")
--THIRD ROUND SYMBOL ! (12x)
r("and","!ě")
r("not","!š")
r("print","!č")
r(" == ","!ř")
r(" ~= ","!ž")
r("= fs.exists%(","!ý")
r("=pcall%(","!á")
r("= pcall%(","!í")
r("pcall%(","!é")
r("=fs.open%(","!ú")
r("= fs.open%(","!ů")
r("fs.exists%(","!ˇ")
r("print%(","!´")
--FOURTH ROUND SYMBOL / (12x)
r("=fs.isDir%(","/š")
r("= fs.isDir%(","/č")
r("fs.isDir%(","/ř")
r("=fs.isReadOnly%(","/ž")
r("= fs.isReadOnly%(","/ý")
r("fs.isReadOnly%(","/á")
r("=fs.getDrive%(","/í")
r("= fs.getDrive%(","/é")
r("fs.getDrive%(","/ú")
r("=fs.getSize%(","/ů")
r("= fs.getSize%(","/ˇ")
r("fs.getSize%(","/´")

local target=fs.open(tostring(args[2]),"w")
target.write(t)
target:close()

print("FileSize comprimed:"..fs.getSize(args[2]))
one=tonumber(fs.getSize(shell.resolve(args[1])))/100
size=fs.getSize(args[2])
--[[DEBUG
print("fs.getSize(...):"..fs.getSize(args[1]))
print("one:"..one)
print("size:"..size)
--/DEBUG]]
percent=100-(size/one)
print("comprimed by "..percent.."%")
end

--EXTRACT
local function extract(...)
local args={...}--ARGS ARE SOLVED BEFORE!!!
local file=fs.open(shell.resolve(tostring(args[1])),"r") print("asd")
t=file.readAll()
file:close()
--FIRST ROUND SYMBOL @ (12x)
r("@ě","true")
r("@š","false")
r("@č","setTextScale")
r("@ř","setBackgroundColor")
r("@ž","os.loadAPI")
r("@ý","color")
r("@á","setTextColor")
r("@í","text")
r("@é","Text")
r("@ú","write")
r("@ů","elseif")
r("@ˇ","local")
r("@´","function")
--SECOND ROUND SYMBOL # (12x)
r("#ě","then")
r("#š","end")
r("#č","else")
r("#ř","tostring%(")
r("#ž","tonumber%(")
r("#ý","string")
r("#á","math")
r("#í","=os.pullEventRaw%(")
r("#é","=os.pullEvent%(")
r("#ú","= os.pullEventRaw%(")
r("#ů","= os.pullEvent%(")
r("#ˇ","window")
r("#´","process")
--THIRD ROUND SYMBOL ! (12x)
r("!ě","and")
r("!š","not")
r("!č","print")
r("!ř"," == ")
r("!ž"," ~= ")
r("!ý","= fs.exists%(")
r("!á","=pcall%(")
r("!í","= pcall%(")
r("!é","pcall%(")
r("!ú","=fs.open%(")
r("!ů","= fs.open%(")
r("!ˇ","fs.exists%(")
r("!´","print%(")
--FOURTH ROUND SYMBOL / (12x)
r("/š","=fs.isDir%(")
r("/č","= fs.isDir%(")
r("/ř","fs.isDir%(")
r("/ž","=fs.isReadOnly%(")
r("/ý","= fs.isReadOnly%(")
r("/á","fs.isReadOnly%(")
r("/í","=fs.getDrive%(")
r("/é","= fs.getDrive%(")
r("/ú","fs.getDrive%(")
r("/ů","=fs.getSize%(")
r("/ˇ","= fs.getSize%(")
r("/´","fs.getSize%(")

local target=fs.open(args[2],"w")
target.write(t)
target:close()

print("done!")
end

if tostring(tArgs[1])=="compress" or tostring(tArgs[1])=="c" then
compress(tArgs[2],tArgs[3])
elseif tostring(tArgs[1])=="extract" or tostring(tArgs[1])=="e" then
extract(tArgs[2],tArgs[3])
elseif tostring(tArgs[1])=="help" or tostring(tArgs[1])=="?" then
help()
else
usage()
end
