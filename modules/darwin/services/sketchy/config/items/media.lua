local icons = require "icons"
local colors = require("colors").sections.media

local whitelist = { ["net.imput.helium"] = true, ["com.apple.Music"] = true }

local media_playback = sbar.add("item", {
  position = "right",
  update_freq = 60,
  icon = {
    max_chars = 30,
    padding_left = 8,
  },
  label = {
    string = icons.separators.left .. " " .. icons.music,
    padding_right = 8,
    padding_left = 4,
    color = colors.label,
  },
  popup = {
    horizontal = true,
    align = "center",
    y_offset = 2,
  },
  padding_right = 8,
})

sbar.add("item", {
  position = "popup." .. media_playback.name,
  padding_left = 6,
  padding_right = 6,
  icon = { string = icons.media.back },
  label = { drawing = false },
  background = { drawing = false },
  click_script = "/opt/homebrew/bin/media-control previous-track",
})
sbar.add("item", {
  position = "popup." .. media_playback.name,
  padding_left = 6,
  padding_right = 6,
  icon = { string = icons.media.play_pause },
  label = { drawing = false },
  background = { drawing = false },
  click_script = "/opt/homebrew/bin/media-control toggle-play-pause",
})
sbar.add("item", {
  position = "popup." .. media_playback.name,
  padding_left = 6,
  padding_right = 6,
  icon = { string = icons.media.forward },
  label = { drawing = false },
  background = { drawing = false },
  click_script = "/opt/homebrew/bin/media-control next-track",
})

-- media_playback:subscribe("media_change", function(env)
--   if whitelist[env.INFO.app] then
--     local drawing = (env.INFO.state == "playing")
--     media_playback:set { drawing = drawing, icon = env.INFO.artist .. " - " .. env.INFO.title }
--   end
-- end)

media_playback:subscribe("media_stream_changed", "routine", function(env)
  media_playback:set {
    icon = {
      string = env.artist .. " - " .. env.title,
      color = env.playing == "true" and colors.label or require("colors").sections.bar.transparent,
    },
  }
end)

media_playback:subscribe("mouse.clicked", function(_)
  -- sbar.animate("tanh", 8, function()
  --   media_playback:set {
  --     background = {
  --       shadow = {
  --         distance = 0,
  --       },
  --     },
  --     y_offset = -4,
  --     padding_left = 8,
  --     padding_right = 4,
  --   }
  --   media_playback:set {
  --     background = {
  --       shadow = {
  --         distance = 4,
  --       },
  --     },
  --     y_offset = 0,
  --     padding_left = 4,
  --     padding_right = 8,
  --   }
  -- end)
  media_playback:set { popup = { drawing = "toggle" } }
end)
