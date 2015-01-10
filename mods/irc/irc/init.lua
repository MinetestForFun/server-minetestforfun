local name = ...
name = name:gsub("%.init$", "")

local irc = require(name..".main")
require(name..".util")
require(name..".asyncoperations")
require(name..".handlers")
require(name..".messages")

return irc

