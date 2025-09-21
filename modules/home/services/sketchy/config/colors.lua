local theme = require "theme"

local M = {}

local with_alpha = function(color, alpha)
  if alpha > 1.0 or alpha < 0.0 then
    return color
  end
  return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local transparent = 0x00000000

M.sections = {
  bar = {
    bg = with_alpha(theme.crust, 0.7),
    transparent = transparent,
    border = transparent,
  },
  item = {
    bg = theme.base,
    border = theme.crust,
    text = theme.text,
  },
  apple = theme.blue,
  spaces = {
    icon = {
      color = theme.muted,
      highlight = theme.text,
    },
    label = {
      color = theme.text,
      highlight = theme.blue,
    },
    indicator = theme.blue,
  },
  media = {
    label = theme.muted,
    highlight = theme.blue,
  },
  widgets = {
    battery = {
      low = theme.red,
      mid = theme.yellow,
      high = theme.green,
    },
    wifi = { icon = theme.blue },
    volume = {
      icon = theme.purple,
      popup = {
        item = theme.muted,
        highlight = theme.text,
      },
      slider = {
        highlight = theme.blue,
        bg = theme.crust,
        border = theme.mantle,
      },
    },
    messages = { icon = theme.red },
  },
  calendar = {
    label = theme.muted,
  },
  popup = {
    bg = theme.base,
    border = theme.blue,
    text = theme.text,
  },
}

return M
