local nfs = require("nativefs")

assert(load(nfs.read(CPLUS.mod_dir .. "structures/challenge.lua")))()

assert(load(nfs.read(CPLUS.mod_dir .. "structures/modifier.lua")))()

local CHALLENGES = {
	empty_challenge = CPlusChallenge:get_empty(),

	--- @type table<string, CPlusChallenge>
	loaded_challenges = {},

	--- @type table<string, CPlusModifier>
	loaded_modifiers = {},
}
CPLUS.CHALLENGES = CHALLENGES

--- @return CPlusChallenge
function CHALLENGES.new_challenge(id, meta, config)
	local ch = CPlusChallenge:new(id, meta, config)
	CHALLENGES.loaded_challenges[ch.id] = ch
	return ch
end
--- @return CPlusModifier
function CHALLENGES.new_modifier(id, meta)
	local mod = CPlusModifier:new(id, meta)
	CHALLENGES.loaded_modifiers[mod.id] = mod
	return mod
end

function CHALLENGES.apply_modifier(arg)
	local mod = CHALLENGES.loaded_modifiers[arg.id]
	if mod then
		mod:apply_to_run(arg)
	end
end

function CHALLENGES.init()
	-- Load modifiers
	for _, item in ipairs(nfs.getDirectoryItems(CPLUS.mod_dir .. "modifiers")) do
		local item_path = CPLUS.mod_dir .. "modifiers/" .. item
		if nfs.getInfo(item_path, "file") then
			assert(load(nfs.read(item_path)))()
		end
	end
	-- Load challenges
	for _, item in ipairs(nfs.getDirectoryItems(CPLUS.mod_dir .. "challenges")) do
		local item_path = CPLUS.mod_dir .. "challenges/" .. item
		if nfs.getInfo(item_path, "file") then
			assert(load(nfs.read(item_path)))()
		end
	end

	for k, ch in pairs(CHALLENGES.loaded_challenges) do
		print(k)
		table.insert(G.CHALLENGES, ch:to_config())
	end
end
