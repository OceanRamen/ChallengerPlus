-- Return to challenges list and clean up
function G.FUNCS.back_to_challenge_list(e)
  local challenge_copy = G.challenge_setup_tab
  local challenge_page = math.floor(
    (get_challenge_int_from_id(challenge_copy.id) - 1) / G.CHALLENGE_PAGE_SIZE
  ) + 1
  G.challenge_setup_tab = nil

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
  local challenge_copy = challenge.toConfig and challenge:toConfig() or {}

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
  if Galdur then
    Galdur.run_setup.choices.challenge = G.challenge_setup_tab
  end
  local definition = (
    Galdur and Galdur.config.use and G.UIDEF.run_setup_option_new_model
    or G.UIDEF.run_setup_option
  )
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
            G.UIDEF.challenge_description(
              get_challenge_int_from_id(G.GAME.challenge),
              nil,
              true
            ),
          },
        }
      end,
    }
  end

  return create_tabs_ref(args)
end

function inject_challenge_deck(add)
  local challenge_deck_config = G.P_CENTERS.b_challenge
  local is_first_in_pool = G.P_CENTER_POOLS.Back[1] == challenge_deck_config
  if add then
    if not is_first_in_pool then
      table.insert(G.P_CENTER_POOLS.Back, 1, challenge_deck_config)
    end
  else
    if is_first_in_pool then
      table.remove(G.P_CENTER_POOLS.Back, 1)
    end
  end
  return challenge_deck_config.name
end

--[[
Record and display highest stake challenge was won on.
]]
function set_challenge_usage()
  if
    (G.GAME.selected_back == Back(G.P_CENTERS.b_challenge))
    and G.GAME.challenge
  then
    local chal_key = G.GAME.challenge
    G.PROFILES[G.SETTINGS.profile].chal_usage =
      G.PROFILES[G.SETTINGS.profile].chal_usage
    if G.PROFILES[G.SETTINGS.profile].chal_usage[chal_key] then
      G.PROFILES[G.SETTINGS.profile].chal_usage[chal_key].count = G.PROFILES[G.SETTINGS.profile].chal_usage[chal_key].count
        + 1
    else
      G.PROFILES[G.SETTINGS.profile].chal_usage[chal_key] =
        { count = 1, wins = {}, losses = {} }
    end
    G:save_settings()
  end
end

function set_challenge_win()
  if
    (G.GAME.selected_back == Back(G.P_CENTERS.b_challenge))
    and G.GAME.challenge
  then
    local chal_key = G.GAME.challenge
    G.PROFILES[G.SETTINGS.profile].chal_usage = G.PROFILES[G.SETTINGS.profile].chal_usage
      or {}
    if not G.PROFILES[G.SETTINGS.profile].chal_usage[chal_key] then
      G.PROFILES[G.SETTINGS.profile].chal_usage[chal_key] =
        { count = 1, wins = {}, losses = {} }
    end
    if G.PROFILES[G.SETTINGS.profile].chal_usage[chal_key] then
      G.PROFILES[G.SETTINGS.profile].chal_usage[chal_key].wins[G.GAME.stake] = (
        G.PROFILES[G.SETTINGS.profile].chal_usage[chal_key].wins[G.GAME.stake]
        or 0
      ) + 1
      for i = 1, G.GAME.stake do
        G.PROFILES[G.SETTINGS.profile].chal_usage[chal_key].wins[i] = (
          G.PROFILES[G.SETTINGS.profile].chal_usage[chal_key].wins[i] or 1
        )
      end
    end
    G:save_settings()
  end
end

function get_challenge_win_stake(_chal_key) end

function get_challenge_win_sticker(_chal) end
