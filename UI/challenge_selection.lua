Challenger.challenger_overview = {
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
