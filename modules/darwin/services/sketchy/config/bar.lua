local colors = require("colors").sections.bar

-- Equivalent to the --bar domain
sbar.bar {
  topmost = "window",
  height = 46,
  color = colors.bg,
  padding_right = 14,
  padding_left = 14,
  -- margin = 12,
  -- corner_radius = 10,
  -- y_offset = 8,
  border_color = colors.border,
  border_width = 0,
  blur_radius = 32,
}
