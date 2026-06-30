local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 14
config.font = wezterm.font("Hurmit Nerd Font Mono")
config.color_scheme = "Catppuccin Mocha"
config.cell_width = 1.0
config.line_height = 1.2

config.enable_tab_bar = false

config.default_cursor_style = "SteadyBlock"
config.colors = {
	cursor_border = "#EB9234",
	cursor_bg = "#EB9234",
	cursor_fg = "#000000",
}

-- Finally, return the configuration to wezterm:
return config
