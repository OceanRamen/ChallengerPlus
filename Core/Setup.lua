-- Return to challenges list and clean up
function G.FUNCS.back_to_challenge_list(e)
  G.FUNCS.challenge_list(e)
  G.challenge_setup_tab = nil
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
