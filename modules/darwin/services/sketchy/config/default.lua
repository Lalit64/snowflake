local settings = require "settings"
local colors = require("colors").sections

-- Equivalent to the --default domain
sbar.default {
  updates = "when_shown",
  icon = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Regular"],
      size = 16.0,
    },
    color = colors.item.text,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
    background = { image = { corner_radius = 14 } },
  },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Italic"],
      size = 14.0,
    },
    color = colors.item.text,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  background = {
    height = 26,
    corner_radius = 8,
    color = colors.bar.transparent,
    -- border_color = colors.item.border,
    -- border_width = 2,
    -- shadow = {
    --   drawing = true,
    --   angle = 45,
    --   distance = 4,
    --   color = colors.item.border,
    -- },
  },
  popup = {
    background = {
      color = colors.popup.bg,
      border_color = colors.popup.border,
      border_width = 1.5,
      corner_radius = 8,
      shadow = {
        drawing = true,
        angle = 45,
        distance = 4,
        color = colors.popup.border,
      },
    },
  },
  padding_left = 4,
  padding_right = 4,
  scroll_texts = true,
}
