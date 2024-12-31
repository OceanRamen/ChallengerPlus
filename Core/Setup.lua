-- Return to challenges list and clean up
function G.FUNCS.back_to_challenge_list(e)
	local challenge_copy = G.challenge_setup_tab
	local challenge_page = math.floor((get_challenge_int_from_id(challenge_copy.id) - 1) / G.CHALLENGE_PAGE_SIZE) + 1
	G.challenge_setup_tab = nil
	G.challenge_setup_use_override = nil

	G.challenge_list_page = challenge_page
	G.FUNCS.challenge_list(e)
	G.challenge_list_page = nil

	G.E_MANAGER:add_event(Event({
		func = function()
			G.FUNCS.change_challenge_list_page({
				cycle_config = { current_option = challenge_page },
			})
			G.FUNCS.change_challenge_description({
				config = { id = get_challenge_int_from_id(challenge_copy.id) },
			})
			return true
		end,
	}))

	if Galdur then
		Galdur.run_setup.choices.challenge = nil
	end
end

-- Create deep copy of challenge and proceed run setup
function G.FUNCS.setup_challenge_run(e)
	local from_game_over = false
	local challenge = G.CHALLENGES[e.config.id]
	local challenge_copy = (challenge.toConfig and challenge:toConfig())
		or (challenge.to_config and challenge:to_config())
		or {}

	for k, v in pairs(challenge) do
		if type(v) ~= "function" then
			challenge_copy[k] = v
		end
	end
	if challenge.deck then
		challenge_copy.deck = {}
		for k, v in pairs(challenge.deck) do
			if k ~= "type" and type(v) ~= "function" then
				challenge_copy.deck[k] = v
			end
		end
	end

	G.challenge_setup_tab = challenge_copy
	G.challenge_setup_order = G.challenge_setup_order or 1
	G.challenge_setup_use_override = true
	if Galdur then
		Galdur.run_setup.choices.challenge = G.challenge_setup_tab
	end
	local definition = (Galdur and Galdur.config.use and G.UIDEF.run_setup_option_new_model or G.UIDEF.run_setup_option)
	G.FUNCS.overlay_menu({
		definition = create_UIBox_generic_options({
			back_func = "back_to_challenge_list",
			no_esc = from_game_over,
			contents = {
				{
					n = G.UIT.R,
					config = { align = "cm", padding = 0, draw_layer = 1 },
					nodes = {
						create_tabs({
							tabs = {
								{
									label = localize("b_new_run"),
									chosen = true,
									tab_definition_function = definition,
									tab_definition_function_args = "New Run",
								},
							},
							snap_to_nav = true,
						}),
					},
				},
			},
		}),
	})
end

-- Track is current menu is "run options"
local is_in_run_info_tab = false
local run_info_ref = G.UIDEF.run_info
function G.UIDEF.run_info()
	is_in_run_info_tab = true
	local output = run_info_ref()
	is_in_run_info_tab = false
	return output
end

-- Create challenge tab in "run options"
local create_tabs_ref = create_tabs
function create_tabs(args)
	if args and args["tabs"] and is_in_run_info_tab and G.GAME.challenge then
		args.tabs[#args.tabs + 1] = {
			label = "Challenge",
			tab_definition_function = function()
				return {
					n = G.UIT.ROOT,
					config = {
						offset = { x = 0, y = 0 },
						align = "cm",
						colour = { 0, 0, 0, 0 },
					},
					nodes = {
						G.UIDEF.challenge_description(get_challenge_int_from_id(G.GAME.challenge), nil, true),
					},
				}
			end,
		}
	end

	return create_tabs_ref(args)
end

function G.FUNCS.challenger_plus_update_order(arg)
	G.challenge_setup_order = arg.to_key or 1
end

function iterate_challenge_deck(t)
	local index = 0
	return function()
		index = index + 1
		if t[index] then
			local _card = t[index]
			local key = _card.s .. "_" .. _card.r
			return key, G.P_CARDS[key], _card
		end
		return nil
	end
end

function pick_random_deck()
	local deck = pseudorandom_element(G.P_CENTER_POOLS.Back)
	return deck
end

RANDOM_CHALLENGE_DECK = {
	key = "b_random_challenge",
	name = "Random Challenge Deck",
	stake = 1,
	unlocked = true,
	order = 17,
	pos = { x = 0, y = 4 },
	set = "Back",
	config = {},
	omit = true,
}

local challenge_description_tab_ref = G.UIDEF.challenge_description_tab
function G.UIDEF.challenge_description_tab(args, ...)
	return CPLUS.UI.insert_challenge_info(challenge_description_tab_ref(args, ...), G.CHALLENGES[args._id])
end
