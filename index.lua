ChallengerPlus = setmetatable({
	version = "1.1.0-dev1",

	meta = {},
}, {})

CPlus = ChallengerPlus

require("cplus/utils")
require("cplus/setup")
require("cplus/challenges")

local init_localization_ref = init_localization
function init_localization(...)
	if not G.localization.__cplus_injected then
		local en_loc = require("cplus/localization/en-us")
		CPlus.utils.table_merge(G.localization, en_loc)
		if G.SETTINGS.language ~= "en-us" then
			local success, current_loc = pcall(function()
				return require("cplus/localization/" .. G.SETTINGS.language)
			end)
			if success and current_loc then
				CPlus.utils.table_merge(G.localization, current_loc)
			end
		end
		G.localization.__cplus_injected = true
	end
	return init_localization_ref(...)
end
