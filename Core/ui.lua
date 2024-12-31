local UI = {}
CPLUS.UI = UI

function UI.insert_challenge_info(definition, challenge)
	if not challenge then
		return definition
	end
	local nodes = {}
	for i = 1, #definition.nodes do
		nodes[i] = definition.nodes[i]
	end
	definition.nodes = {
		{
			n = G.UIT.R,
			config = {
				align = "cm",
				padding = args._tab == "Deck" and 0.05 or 0,
				colour = G.C.CLEAR,
			},
			nodes = {
				{
					n = G.UIT.R,
					config = { align = "cm", padding = 0.05, colour = G.C.CLEAR },
					nodes = {
						challenge.id and {
							n = G.UIT.C,
							config = { align = "cm", padding = 0.1, colour = G.C.L_BLACK, r = 0.1 },
							nodes = {
								{
									n = G.UIT.T,
									config = { text = "Challenge Name", scale = 0.3, colour = G.C.UI.TEXT_LIGHT },
								},
								{ n = G.UIT.T, config = { text = ":", scale = 0.3, colour = G.C.UI.TEXT_LIGHT } },
								{
									n = G.UIT.T,
									config = {
										text = localize(challenge.id, "challenge_names"),
										scale = 0.3,
										colour = G.C.DARK_EDITION,
									},
								},
							},
						},
						challenge.meta and challenge.meta.author and {
							n = G.UIT.C,
							config = { align = "cm", padding = 0.1, colour = G.C.L_BLACK, r = 0.1 },
							nodes = {
								{
									n = G.UIT.T,
									config = { text = "Author", scale = 0.3, colour = G.C.UI.TEXT_LIGHT },
								},
								{ n = G.UIT.T, config = { text = ":", scale = 0.3, colour = G.C.UI.TEXT_LIGHT } },
								{
									n = G.UIT.T,
									config = {
										text = challenge.meta.author,
										scale = 0.3,
										colour = G.C.DARK_EDITION,
									},
								},
							},
						},
						challenge.meta and challenge.meta.version and {
							n = G.UIT.C,
							config = { align = "cm", padding = 0.1, colour = G.C.L_BLACK, r = 0.1 },
							nodes = {
								{
									n = G.UIT.T,
									config = { text = "Version", scale = 0.3, colour = G.C.UI.TEXT_LIGHT },
								},
								{ n = G.UIT.T, config = { text = ":", scale = 0.3, colour = G.C.UI.TEXT_LIGHT } },
								{
									n = G.UIT.T,
									config = {
										text = challenge.meta.version,
										scale = 0.3,
										colour = G.C.DARK_EDITION,
									},
								},
							},
						},
					},
				},
			},
		},
		args._tab == "Deck" and {
			n = G.UIT.R,
			config = {
				align = "cm",
				padding = 0.22,
				colour = G.C.CLEAR,
			},
			nodes = {},
		} or nil,
		args._tab == "Deck" and {
			n = G.UIT.R,
			config = {
				align = "cm",
				padding = 0.11,
				colour = G.C.CLEAR,
			},
			nodes = {
				{
					n = G.UIT.R,
					config = {
						align = "cm",
						colour = G.C.CLEAR,
					},
					nodes = nodes,
				},
			},
		} or {
			n = G.UIT.R,
			config = {
				align = "cm",
				padding = 0.05,
				colour = G.C.CLEAR,
			},
			nodes = nodes,
		},
	}
	return definition
end

function UI.get_overview()
	return {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.1, r = 0.1, colour = G.C.BLACK },
		nodes = {
			{
				n = G.UIT.R,
				config = { align = "cm", padding = 0.1 },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = "Challenger+ Overview",
							scale = 0.4,
							colour = G.C.UI.TEXT_LIGHT,
							shadow = true,
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm", minw = 8.5, minh = 1.5, padding = 0.2 },
				nodes = {
					{
						n = G.UIT.C,
						config = {
							align = "cm",
							minw = 4,
							minh = 2,
							padding = 0.2,
							r = 0.01,
						},
						nodes = {},
					},
					{
						n = G.UIT.C,
						config = {
							align = "cm",
							minw = 4,
							minh = 2,
							padding = 0.2,
							r = 0.01,
						},
						nodes = {},
					},
				},
			},
		},
	}
end
