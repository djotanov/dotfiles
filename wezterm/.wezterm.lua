local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_domain = "WSL:Ubuntu-22.04"
config.wsl_domains = {
	{
		name = "WSL:Ubuntu-22.04",
		distribution = "Ubuntu-22.04",
		default_cwd = "/home/dragan",
	},
}

config.color_scheme = "Catppuccin Mocha"
config.window_decorations = "RESIZE"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.93

config.disable_default_key_bindings = true
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- panes
	{ key = "s", mods = "CTRL", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "v", mods = "CTRL", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "o", mods = "CTRL", action = "TogglePaneZoomState" },
	{ key = "z", mods = "CTRL", action = "TogglePaneZoomState" },
	{ key = "h", mods = "CTRL", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "CTRL", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "CTRL", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "CTRL", action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "H", mods = "CTRL|SHIFT", action = act({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "J", mods = "CTRL|SHIFT", action = act({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "K", mods = "CTRL|SHIFT", action = act({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "L", mods = "CTRL|SHIFT", action = act({ AdjustPaneSize = { "Right", 5 } }) },
	{ key = "d", mods = "CTRL", action = act({ CloseCurrentPane = { confirm = true } }) },
	{ key = "x", mods = "CTRL", action = act({ CloseCurrentPane = { confirm = true } }) },

	-- tabs
	{ key = "t", mods = "CTRL", action = act({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "1", mods = "CTRL", action = act({ ActivateTab = 0 }) },
	{ key = "2", mods = "CTRL", action = act({ ActivateTab = 1 }) },
	{ key = "3", mods = "CTRL", action = act({ ActivateTab = 2 }) },
	{ key = "4", mods = "CTRL", action = act({ ActivateTab = 3 }) },
	{ key = "5", mods = "CTRL", action = act({ ActivateTab = 4 }) },
	{ key = "6", mods = "CTRL", action = act({ ActivateTab = 5 }) },
	{ key = "7", mods = "CTRL", action = act({ ActivateTab = 6 }) },
	{ key = "8", mods = "CTRL", action = act({ ActivateTab = 7 }) },
	{ key = "9", mods = "CTRL", action = act({ ActivateTab = 8 }) },
	{ key = "w", mods = "CTRL", action = act({ CloseCurrentTab = { confirm = true } }) },
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{
		key = "E",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- fix for ctrl+space not sending properly.  windows terminal has an identical issue
	{ key = " ", mods = "CTRL", action = act.SendKey({ key = " ", mods = "CTRL" }) },

	-- Copy/Paste
	{ key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "V", mods = "CTRL", action = act.PasteFrom("PrimarySelection") },
	{ key = "C", mods = "CTRL", action = act.CopyTo("ClipboardAndPrimarySelection") },

	-- Font size
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "+", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontAndWindowSize },
}

config.window_frame = {
	font = wezterm.font({ family = "Roboto", weight = "Bold" }),
	font_size = 10.0,

	active_titlebar_bg = "#1e1e2e",
	inactive_titlebar_bg = "#1e1e2e",
	inactive_titlebar_border_bottom = "#1e1e2e",
	active_titlebar_border_bottom = "#1e1e2e",
	button_fg = "#cccccc",
	button_bg = "#1e1e2e",
}

config.mouse_bindings = {
	-- paste
	{ event = { Down = { streak = 1, button = "Right" } }, mods = "NONE", action = act({ PasteFrom = "Clipboard" }) },
}

return config

