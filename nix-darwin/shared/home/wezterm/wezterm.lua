local mux = wezterm.mux

-- This is where you actually apply your config choices
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return {
	-- my coolnight colorscheme
	colors = {
		foreground = "#CBE0F0",
		background = "#011423",
		cursor_bg = "#47FF9C",
		cursor_border = "#47FF9C",
		cursor_fg = "#011423",
		selection_bg = "#033259",
		selection_fg = "#CBE0F0",
		ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
		brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
	},

	font = wezterm.font("MesloLGS Nerd Font Mono"),
	font_size = 23,

	enable_tab_bar = false,
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	},

	window_decorations = "RESIZE",
	window_background_opacity = 0.85,
	macos_window_background_blur = 10,

	window_padding = {
		right = 0,
		bottom = 0,
	},

	keys = {
		-- Move between windows
		{
			key = "f",
			mods = "CTRL|CMD",
			action = wezterm.action.ToggleFullScreen,
		},
	},

	front_end = "WebGpu",
}
