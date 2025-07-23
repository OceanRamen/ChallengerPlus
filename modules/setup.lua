CPlus.setup = {
	challenge_deck_iterator = function(t)
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
	end,
	create_challenge_setup_button = function(challenge_id)
		return {
			n = G.UIT.C,
			config = {
				align = "cm",
				padding = 0.1,
				minh = 0.7,
				minw = 4.1,
				r = 0.1,
				hover = true,
				colour = G.C.PURPLE,
				button = "cplus_setup_challenge_run",
				shadow = true,
				id = challenge_id,
			},
			nodes = {
				{
					n = G.UIT.O,
					config = {
						object = DynaText({
							string = { "CUSTOMIZE" },
							colours = { G.C.UI.TEXT_LIGHT },
							shadow = true,
							float = false,
							bump = true,
							silent = true,
							pop_in = 0.1,
							scale = 0.5,
						}),
					},
				},
			},
		}
	end,
	create_challenge_run_modifiers_toggle = function()
		return {
			n = G.UIT.R,
			config = { align = "cm", padding = 0.05 },
			nodes = {
				{
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {
						{
							n = G.UIT.T,
							config = {
								align = "cm",
								padding = 0.1,
								text = "Run modifiers order",
								colour = G.C.UI.TEXT_LIGHT,
								scale = 0.4,
							},
						},
					},
				},
				{
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {
						create_option_cycle({
							options = { "Stake+Deck/Challenge", "Challenge/Stake+Deck" },
							opt_callback = "challenger_plus_update_order",
							current_option = G.challenge_setup_order,
							colour = G.C.RED,
							scale = 0.8,
							w = 4,
						}),
					},
				},
			},
		}
	end,

	remove_challenge_deck_from_pool = function()
		if G.P_CENTER_POOLS.Back.__cplus_inserted_challenge then
			table.remove(G.P_CENTER_POOLS.Back, 1)
			G.P_CENTER_POOLS.Back.__cplus_inserted_challenge = nil
			return true
		end
		return false
	end,
	add_challenge_deck_to_pool = function()
		if not G.P_CENTER_POOLS.Back.__cplus_inserted_challenge then
			table.insert(G.P_CENTER_POOLS.Back, 1, G.P_CENTERS.b_challenge)
			G.P_CENTER_POOLS.Back.__cplus_inserted_challenge = true
			return true
		end
		return false
	end,
}

-- Return to challenges list and clean up
function G.FUNCS.cplus_back_to_challenge_list(e)
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
function G.FUNCS.cplus_setup_challenge_run(e)
	local from_game_over = false
	local challenge_copy = G.CHALLENGES[e.config.id]

	G.challenge_setup_tab = challenge_copy
	G.challenge_setup_order = G.challenge_setup_order or 1
	G.challenge_setup_use_override = true
	if Galdur then
		Galdur.run_setup.choices.challenge = G.challenge_setup_tab
	end
	local definition = (Galdur and Galdur.config.use and G.UIDEF.run_setup_option_new_model or G.UIDEF.run_setup_option)
	G.FUNCS.overlay_menu({
		definition = create_UIBox_generic_options({
			back_func = "cplus_back_to_challenge_list",
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
-- TODO: display challenge name
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

local exit_overlay_ref = G.FUNCS.exit_overlay_menu
function G.FUNCS.exit_overlay_menu(...)
	CPlus.setup.remove_challenge_deck_from_pool()
	return exit_overlay_ref(...)
end
