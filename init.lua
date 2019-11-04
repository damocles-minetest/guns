
local MP = minetest.get_modpath("guns")


guns = {}

dofile(MP.."/can_shoot.lua")
dofile(MP.."/common.lua")
dofile(MP.."/api.lua")

dofile(MP.."/ammo/9mm.lua")
dofile(MP.."/ammo/shell.lua")

dofile(MP.."/guns/beretta.lua")
dofile(MP.."/guns/colt45.lua")
dofile(MP.."/guns/deagle.lua")
dofile(MP.."/guns/awp.lua")
dofile(MP.."/guns/scout.lua")
dofile(MP.."/guns/spas12.lua")
