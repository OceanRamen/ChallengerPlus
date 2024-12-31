local nfs = require("nativefs")

ChallengerPlus = setmetatable(ChallengerPlus, {})
CPLUS = ChallengerPlus

function CPLUS.process_loc_text()
	for k, v in pairs(CPLUS.CHALLENGES.loaded_challenges) do
		G.localization.misc.challenge_names[v.id] = v.meta.name
	end
	for k, v in pairs(CPLUS.CHALLENGES.loaded_modifiers) do
		G.localization.misc.v_text["ch_c_" .. v.id] = v.meta.text
	end

	G.localization.descriptions.Back.b_random_challenge = {
		name = "Random Challenge Deck",
		text = {
			"Each run, deck",
			"selected {C:attention}randomly",
		},
	}
end

function CPLUS.emplace_steamodded()
	CPLUS.current_mod = SMODS.current_mod
	-- CPLUS.mod_dir = CPLUS.current_mod.path
	CPLUS.current_mod.process_loc_text = CPLUS.process_loc_text
end

function CPLUS.init()
	assert(load(nfs.read(CPLUS.mod_dir .. "core/ui.lua")))()
	assert(load(nfs.read(CPLUS.mod_dir .. "core/challenges.lua")))()
	assert(load(nfs.read(CPLUS.mod_dir .. "core/setup.lua")))()

	CPLUS.CHALLENGES.init()
end
