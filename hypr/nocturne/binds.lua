--==========================================================
-- Nocturne
-- Keybindings
--==========================================================

local main_mod = "SUPER"
local secondary_mod = "ALT"

local resize_step = 40

-------------------------------------------------------------
-- Master shortcut lock
-------------------------------------------------------------

hl.bind(
	main_mod .. " + " .. secondary_mod .. " + X",
	hl.dsp.submap("clean"),
	{ description = "Disable shortcuts" }
)

hl.bind(
	main_mod .. " + " .. secondary_mod .. " + Y",
	hl.dsp.submap("reset"),
	{ description = "Enable shortcuts" }
)

hl.bind(
	main_mod .. " + " .. secondary_mod .. " + X",
	hl.dsp.exec("notify-send 'Shortcuts disabled'"),
	{ description = "Disable shortcuts" }
)

hl.bind(
	main_mod .. " + " .. secondary_mod .. " + Y",
	hl.dsp.exec("notify-send 'Shortcuts enabled'"),
	{ description = "Enable shortcuts" }
)

-------------------------------------------------------------
-- Applications
-------------------------------------------------------------

hl.bind(secondary_mod .. " + T", hl.dsp.exec("kitty"), { description = "Open terminal" })

hl.bind(
	secondary_mod .. " + B",
	hl.dsp.exec("/usr/bin/zen-browser"),
	{ description = "Open browser" }
)

hl.bind(secondary_mod .. " + E", hl.dsp.exec("dolphin"), { description = "Open file manager" })

hl.bind(
	secondary_mod .. " + R",
	hl.dsp.exec([[rofi -show drun -i -theme ~/.config/rofi/launcher/theme.rasi]]),
	{ description = "Open application launcher" }
)

hl.bind(secondary_mod .. " + N", hl.dsp.exec("obsidian"), { description = "Open Obsidian" })

hl.bind(secondary_mod .. " + Z", hl.dsp.exec("waybar"), { description = "Launch Waybar" })

hl.bind(secondary_mod .. " + P", hl.dsp.exec("hyprpicker -ar"), { description = "Pick color" })

hl.bind(
	secondary_mod .. " + SPACE",
	hl.dsp.exec("rofi -show calc -modi calc -no-show-match -no-sort"),
	{ description = "Open calculator" }
)

-------------------------------------------------------------
-- Screenshots
-------------------------------------------------------------

hl.bind(
	"PRINT",
	hl.dsp.exec("hyprshot -m output --freeze --output-folder ~/Pictures/Screenshots/"),
	{ description = "Screenshot monitor" }
)

hl.bind(
	"SHIFT + PRINT",
	hl.dsp.exec("hyprshot -m region --freeze --output-folder ~/Pictures/Screenshots/"),
	{ description = "Screenshot region" }
)

-------------------------------------------------------------
-- Clipboard
-------------------------------------------------------------

hl.bind(
	secondary_mod .. " + V",
	hl.dsp.exec(
		[[cliphist list | rofi -dmenu -i -p "(づ๑•ᴗ•๑)づ♡" | cliphist decode | wl-copy]]
	),
	{ description = "Open clipboard history" }
)

-------------------------------------------------------------
-- Windows
-------------------------------------------------------------

hl.bind(main_mod .. " + M", hl.dsp.dispatch("exit"), { description = "Exit Hyprland" })

hl.bind(main_mod .. " + Q", hl.dsp.window.kill(), { description = "Close active window" })

hl.bind(main_mod .. " + F", hl.dsp.dispatch("fullscreen"), { description = "Toggle fullscreen" })

hl.bind(main_mod .. " + V", hl.dsp.dispatch("togglefloating"), { description = "Toggle floating" })

hl.bind(main_mod .. " + P", hl.dsp.dispatch("pseudo"), { description = "Toggle pseudotile" })

hl.bind(main_mod .. " + Z", hl.dsp.exec("pkill waybar"), { description = "Close Waybar" })

hl.bind(main_mod .. " + L", hl.dsp.exec("hyprlock"), { description = "Lock screen" })

hl.bind(
	main_mod .. " + X",
	hl.dsp.exec(
		[[rofi -show p -modi p:'rofi-power-menu --symbols-font "Symbols Nerd Font Mono"' -font "RecMonoLinear NF 16" -theme-str 'window {width: 8em;} listview {lines: 6;}']]
	),
	{ description = "Open power menu" }
)

-------------------------------------------------------------
-- Focus
-------------------------------------------------------------

hl.bind(main_mod .. " + LEFT", hl.dsp.dispatch("movefocus l"), { description = "Focus left" })

hl.bind(main_mod .. " + RIGHT", hl.dsp.dispatch("movefocus r"), { description = "Focus right" })

hl.bind(main_mod .. " + UP", hl.dsp.dispatch("movefocus u"), { description = "Focus up" })

hl.bind(main_mod .. " + DOWN", hl.dsp.dispatch("movefocus d"), { description = "Focus down" })

-------------------------------------------------------------
-- Workspaces
-------------------------------------------------------------

for i = 1, 9 do
	hl.bind(
		main_mod .. " + " .. i,
		hl.dsp.dispatch("workspace " .. i),
		{ description = "Switch to workspace " .. i }
	)

	hl.bind(
		main_mod .. " + SHIFT + " .. i,
		hl.dsp.dispatch("movetoworkspace " .. i),
		{ description = "Move window to workspace " .. i }
	)
end

hl.bind(
	main_mod .. " + 0",
	hl.dsp.dispatch("workspace 10"),
	{ description = "Switch to workspace 10" }
)

hl.bind(
	main_mod .. " + SHIFT + 0",
	hl.dsp.dispatch("movetoworkspace 10"),
	{ description = "Move window to workspace 10" }
)

-------------------------------------------------------------
-- Workspace scrolling
-------------------------------------------------------------

hl.bind(
	main_mod .. " + mouse_down",
	hl.dsp.dispatch("workspace e+1"),
	{ description = "Next workspace" }
)

hl.bind(
	main_mod .. " + mouse_up",
	hl.dsp.dispatch("workspace e-1"),
	{ description = "Previous workspace" }
)

-------------------------------------------------------------
-- Mouse window movement / resizing
-------------------------------------------------------------

hl.bind(
	main_mod .. " + mouse:272",
	hl.dsp.window.movewindow(),
	{ description = "Move window with mouse" }
)

hl.bind(
	main_mod .. " + mouse:273",
	hl.dsp.window.resizewindow(),
	{ description = "Resize window with mouse" }
)

-------------------------------------------------------------
-- Keyboard window resizing
-------------------------------------------------------------

hl.bind(
	main_mod .. " + SHIFT + RIGHT",
	hl.dsp.dispatch("resizeactive " .. resize_step .. " 0"),
	{ description = "Increase window width" }
)

hl.bind(
	main_mod .. " + SHIFT + LEFT",
	hl.dsp.dispatch("resizeactive -" .. resize_step .. " 0"),
	{ description = "Decrease window width" }
)

hl.bind(
	main_mod .. " + SHIFT + UP",
	hl.dsp.dispatch("resizeactive 0 -" .. resize_step),
	{ description = "Decrease window height" }
)

hl.bind(
	main_mod .. " + SHIFT + DOWN",
	hl.dsp.dispatch("resizeactive 0 " .. resize_step),
	{ description = "Increase window height" }
)

-------------------------------------------------------------
-- Audio
-------------------------------------------------------------

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec("swayosd-client --output-volume=+5"),
	{ description = "Increase volume" }
)

hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec("swayosd-client --output-volume=-5"),
	{ description = "Decrease volume" }
)

hl.bind(
	"XF86AudioMute",
	hl.dsp.exec("swayosd-client --output-volume=mute-toggle"),
	{ description = "Toggle speaker mute" }
)

hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec("swayosd-client --input-volume=mute-toggle"),
	{ description = "Toggle microphone mute" }
)

-------------------------------------------------------------
-- Brightness
-------------------------------------------------------------

hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec("swayosd-client --brightness=+5"),
	{ description = "Increase brightness" }
)

hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec("swayosd-client --brightness=-5"),
	{ description = "Decrease brightness" }
)
