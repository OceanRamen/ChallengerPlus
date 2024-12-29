local nfs = require("nativefs")
local lovely = require("lovely")

ChallengerPlus = {}
CPLUS = ChallengerPlus

CPLUS.not_found = true
for _, item in ipairs(nfs.getDirectoryItems(lovely.mod_dir)) do
	local item_path = lovely.mod_dir .. "/" .. item
	if nfs.getInfo(item_path, "directory") and string.lower(item):find("challengerplus") then
		CPLUS.mod_dir = item_path .. "/"
		CPLUS.not_found = nil
		break
	end
end

if CPLUS.not_found then
	error("ERROR: Unable to locate ChallengerPlus directory.")
end

assert(load(nfs.read(CPLUS.mod_dir .. "libs/utilities.lua")))()

assert(load(nfs.read(CPLUS.mod_dir .. "core/main.lua")))()

CPLUS.init()
