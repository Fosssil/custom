--==========================================================
-- Hyprland Configuration
-- Hyprland 0.55+
-- Author : Fosssil
--==========================================================
-------------------------------------------------------------
-- Constants
-------------------------------------------------------------
-- Numeric values that define the overall feel of Nocturne.
-- Changing them here affects the entire configuration.

hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user start hyprland-session.target")
end)

hl.on("hyprland.shutdown", function()
	os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)

local constants = {
	-- Window
	resizeStep = 40,

	-- Media
	volumeStep = 5,
	brightnessStep = 5,

	screenshotDir = "$HOME/Pictures/Screenshots",
}
-------------------------------------------------------------
-- Programs
-------------------------------------------------------------

local programs = {
	-- terminal = "konsole",
	terminal = "kitty",
	browser = "/usr/bin/zen-browser",
	fileManager = "dolphin",
	launcher = [[rofi -show drun -i -theme ~/.config/rofi/launcher/theme.rasi]],
	picker = "hyprpicker -ar",
	calculator = [[rofi -show calc -modi calc -no-show-match -no-sort -no-history -terse -no-bold -theme ~/.config/rofi/calc/theme.rasi]],
	-- terse --> reduce the output of qalc to just the result
	notes = "obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland",
}
-- local nocturne = require("nocturne.variables")
-- local programs = nocturne.programs

-------------------------------------------------------------
-- Modifiers
-------------------------------------------------------------
-- Modifier keys used throughout the configuration.
--
-- Keeping them here means changing SUPER to ALT
-- (or any other modifier) only requires editing
-- one place.

local mods = {
	main = "SUPER",
	alt = "ALT",
	shift = "SHIFT",
	ctrl = "CTRL",
}

-------------------------------------------------------------
-- Environment
-------------------------------------------------------------

local env = {
	cursor = {
		XCURSOR_SIZE = 20,
		HYPRCURSOR_SIZE = 20,
	},

	qt = {
		QT_QPA_PLATFORMTHEME = "qt6ct",
	},
}

-------------------------------------------------------------
-- Apply Environment Variables
-------------------------------------------------------------

-- pairs(env) iterates over each environment category.
--
-- First iteration:
-- variables = env.cursor
--
-- Second iteration:
-- variables = env.qt
for _, variables in pairs(env) do
	-- variables contains a table of
	-- environment variable names and values.
	for key, value in pairs(variables) do
		-- Hyprland expects string values.
		hl.env(key, tostring(value))
	end
end

-------------------------------------------------------------
-- User Interface
-------------------------------------------------------------

local ui = {
	border = {
		size = 1,
	},

	gaps = {
		inner = 4,
		outer = 4,
	},

	corners = {
		rounding = 2,
	},

	opacity = {
		active = 1.0,
		inactive = 0.9,
	},

	blur = {
		enabled = true,
		size = 6, --previous 5
		passes = 2, --previous 3
		vibrancy = 0.15, --previous 0.1696
		new_optimizations = true,
		popups = true,
	},

	shadow = {
		enabled = true,
		range = 4,
		render_power = 4,
	},
}
-------------------------------------------------------------
-- General
-------------------------------------------------------------

local general = {
	border_size = ui.border.size,
	gaps_in = ui.gaps.inner,
	gaps_out = ui.gaps.outer,
	allow_tearing = false,
	layout = "dwindle",
}

-------------------------------------------------------------
-- Decoration
-------------------------------------------------------------
-- This table controls the visual appearance
-- of windows.
--
-- Values are taken from the ui table so that
-- all visual settings remain in one place.

local decoration = {
	rounding = ui.corners.rounding,
	active_opacity = ui.opacity.active,
	inactive_opacity = ui.opacity.inactive,

	shadow = {
		enabled = ui.shadow.enabled,
		range = ui.shadow.range,
		render_power = ui.shadow.render_power,
	},

	blur = {
		enabled = ui.blur.enabled,
		size = ui.blur.size,
		passes = ui.blur.passes,
		vibrancy = ui.blur.vibrancy,
		new_optimizations = ui.blur.new_optimizations,
		popups = ui.blur.popups,
	},
}

-------------------------------------------------------------
-- Input
-------------------------------------------------------------
-- Controls keyboard, mouse and touchpad behaviour.
--
-- Some settings are global while others are
-- device-specific. We'll later add a dedicated
-- device configuration for your external mouse
-- and laptop touchpad.

local input = {

	kb_layout = "us",
	sensitivity = 0,
	follow_mouse = 1,

	touchpad = {
		tap_to_click = true,
		natural_scroll = false,
		disable_while_typing = true,
	},
}

-------------------------------------------------------------
-- Cursor
-------------------------------------------------------------
-- Controls Hyprland's cursor behaviour.
--
-- Cursor theme and size are configured through
-- XCURSOR_* and HYPRCURSOR_* environment variables.

local cursor = {

	-- Hide cursor after X seconds of inactivity.
	-- 0 = never hide.
	inactive_timeout = 0,

	-- Use hardware cursors whenever possible.
	--
	-- 0 = Always use hardware cursors
	-- 1 = Disable hardware cursors
	-- 2 = Automatic (recommended by Hyprland)
	no_hardware_cursors = 2,
}

-------------------------------------------------------------
-- Monitors
-------------------------------------------------------------

local monitors = {
	{
		output = "eDP-1",
		mode = "preferred",
		position = "auto",
		scale = 1.0,
		vrr = 1,
	},

	{
		output = "HDMI-A-1",
		mode = "preferred",
		position = "auto",
		scale = 1.0,
		mirror = "eDP-1",
	},
}

-------------------------------------------------------------
-- Apply Monitor Configuration
-------------------------------------------------------------

-- ipairs(monitors) iterates over the monitor list
-- in the same order they are defined.
for _, monitor in ipairs(monitors) do
	-- monitor contains the configuration for
	-- one monitor (output, mode, scale, etc.)
	hl.monitor(monitor)
end

-------------------------------------------------------------
-- Animations
-------------------------------------------------------------
-- Controls window animations.
--
-- Hyprland stores animations as a list.
-- Each entry describes one animation.

-------------------------------------------------------------
-- Animation Curves
-------------------------------------------------------------
-- Curves describe *how* something moves.
-- They are reused by multiple animations.

hl.curve("nocturne", {
	type = "bezier",

	points = {
		{ 0.22, 1.00 },
		{ 0.36, 1.00 },
	},
})

-------------------------------------------------------------
-- Window Animation
-------------------------------------------------------------

hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 3.5,
	bezier = "nocturne",
	style = "slide",
})

-------------------------------------------------------------
-- Gestures
-------------------------------------------------------------

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-------------------------------------------------------------
-- Binds
-------------------------------------------------------------
-- Global behaviour for all keybindings.

local binds = {

	-- Returning to the current workspace
	-- jumps back to the previous one.
	workspace_back_and_forth = true,

	-- Hide scratchpad when changing workspace.
	hide_special_on_workspace_change = true,

	-- Remember workspace history.
	allow_workspace_cycles = true,

	-- Focus the last active window when changing
	-- workspaces instead of centering the cursor.
	workspace_center_on = 1,

	-- Better directional focus.
	focus_preferred_method = 1,

	-- Allows moving focus across monitors.
	window_direction_monitor_fallback = true,
}
-------------------------------------------------------------
-- Configuration
-------------------------------------------------------------

hl.config({
	autogenerated = false,
	general = general,
	decoration = decoration,
	input = input,
	cursor = cursor,
	animations = {
		enabled = true,
	},
	binds = binds,
	dwindle = {
		preserve_split = true,
	},
})

-------------------------------------------------------------
-- Helper Functions
-------------------------------------------------------------
-- Create a keybinding that executes a shell command.
--
-- Example:
-- bind(mods.alt, "T", programs.terminal)
local function bindExec(mod, key, command)
	local binding = key
	if mod ~= "" then
		binding = mod .. " + " .. key
	end
	hl.bind(binding, hl.dsp.exec_cmd(command))
end

-- Create a keybinding that executes a Hyprland dispatcher.
local function bindDispatch(mod, key, dispatcher, options)
	hl.bind(mod .. " + " .. key, dispatcher, options)
end

-------------------------------------------------------------
-- Application Keybindings
-------------------------------------------------------------
-- Launch frequently used applications.
--
-- bind(modifier, key, command)
--
local appBindings = {
	{ key = "T", command = programs.terminal },
	{ key = "B", command = programs.browser },
	{ key = "E", command = programs.fileManager },
	{ key = "R", command = programs.launcher },
	{ key = "N", command = programs.notes },
	{ key = "P", command = programs.picker },
	{ key = "SPACE", command = programs.calculator },
}

for _, app in ipairs(appBindings) do
	bindExec(mods.alt, app.key, app.command)
end

-------------------------------------------------------------
-- Window Keybindings
-------------------------------------------------------------

bindDispatch(mods.main, "Q", hl.dsp.window.close())
bindDispatch(mods.main, "F", hl.dsp.window.fullscreen())
bindDispatch(
	mods.main,
	"V",
	hl.dsp.window.float({
		action = "toggle",
	})
)
bindDispatch(mods.main, "P", hl.dsp.window.pseudo())

-------------------------------------------------------------
-- Workspace Helper
-------------------------------------------------------------
-- Creates bindings related to workspaces.

local function bindWorkspace(mod, key, workspace)
	bindDispatch(
		mod,
		key,
		hl.dsp.focus({
			workspace = workspace,
		})
	)
end

local function bindMoveToWorkspace(mod, key, workspace)
	bindDispatch(
		mod,
		key,
		hl.dsp.window.move({
			workspace = workspace,
		})
	)
end

-------------------------------------------------------------
-- Modifier Combinations
-------------------------------------------------------------
-- Frequently used modifier combinations.
-- This avoids repeating string concatenation.

local combo = {

	mainShift = mods.main .. " + " .. mods.shift,
}
-------------------------------------------------------------
-- Workspace Keybindings
-------------------------------------------------------------

for workspace = 1, 10 do
	-- Workspace 10 is mapped to keyboard key 0.
	local key = workspace % 10
	bindWorkspace(mods.main, tostring(key), workspace)
	bindMoveToWorkspace(combo.mainShift, tostring(key), workspace)
end

-------------------------------------------------------------
-- Workspace Scrolling
-------------------------------------------------------------
-- Scroll through workspaces while holding SUPER.

bindDispatch(
	mods.main,
	"mouse_down",
	hl.dsp.focus({
		workspace = "e-1",
	})
)

bindDispatch(
	mods.main,
	"mouse_up",
	hl.dsp.focus({
		workspace = "e+1",
	})
)

-------------------------------------------------------------
-- Window Navigation
-------------------------------------------------------------
-- Directional navigation.
--
-- Arrow keys are kept because they match your existing
-- muscle memory.

local navigation = {

	{
		key = "left",
		direction = "l",
	},

	{
		key = "right",
		direction = "r",
	},

	{
		key = "up",
		direction = "u",
	},

	{
		key = "down",
		direction = "d",
	},
}

for _, nav in ipairs(navigation) do
	bindDispatch(

		mods.main,

		nav.key,

		hl.dsp.focus({
			direction = nav.direction,
		})
	)
end

-------------------------------------------------------------
-- Window Resize
-------------------------------------------------------------
-- Resize the active window using arrow keys.

local resizeBindings = {

	{
		key = "left",
		x = -constants.resizeStep,
		y = 0,
	},

	{
		key = "right",
		x = constants.resizeStep,
		y = 0,
	},

	{
		key = "up",
		x = 0,
		y = -constants.resizeStep,
	},

	{
		key = "down",
		x = 0,
		y = constants.resizeStep,
	},
}

for _, resize in ipairs(resizeBindings) do
	bindDispatch(

		mods.main .. " + " .. mods.shift,

		resize.key,

		hl.dsp.window.resize({

			x = resize.x,

			y = resize.y,

			relative = true,
		})
	)
end
-------------------------------------------------------------
-- Mouse Actions
-------------------------------------------------------------
-- Mouse shortcuts for moving and resizing windows.
--
-- Left Button  (272) : Move floating window.
-- Right Button (273) : Resize floating window.

bindDispatch(mods.main, "mouse:272", hl.dsp.window.drag(), { mouse = true })

bindDispatch(mods.main, "mouse:273", hl.dsp.window.resize(), { mouse = true })

-------------------------------------------------------------
-- Media Commands
-------------------------------------------------------------

local media = {
	volume = {
		up = "swayosd-client --output-volume=+" .. constants.volumeStep,
		down = "swayosd-client --output-volume=-" .. constants.volumeStep,
		mute = "swayosd-client --output-volume=mute-toggle",
	},

	microphone = {
		mute = "swayosd-client --input-volume=mute-toggle",
	},

	brightness = {
		up = "swayosd-client --brightness=+" .. constants.brightnessStep,
		down = "swayosd-client --brightness=-" .. constants.brightnessStep,
	},
}

-------------------------------------------------------------
-- Media Keys
-------------------------------------------------------------

bindExec("", "XF86AudioRaiseVolume", media.volume.up)

bindExec("", "XF86AudioLowerVolume", media.volume.down)

bindExec("", "XF86AudioMute", media.volume.mute)

bindExec("", "XF86AudioMicMute", media.microphone.mute)

bindExec("", "XF86MonBrightnessUp", media.brightness.up)

bindExec("", "XF86MonBrightnessDown", media.brightness.down)

-------------------------------------------------------------
-- Session
-------------------------------------------------------------

local session = {

	---------------------------------------------------------
	-- Desktop
	---------------------------------------------------------

	"waybar",
	"swaync",
	"hyprpaper",
	"hypridle",

	---------------------------------------------------------
	-- Authentication
	---------------------------------------------------------

	"systemctl --user start hyprpolkitagent",

	---------------------------------------------------------
	-- Appearance
	---------------------------------------------------------

	"hyprctl setcursor Bibata-Modern-Ice 24",
	"$HOME/.local/bin/theme.sh",

	---------------------------------------------------------
	-- Clipboard
	---------------------------------------------------------

	"wl-paste --type text --watch cliphist store",
	"wl-paste --type image --watch cliphist store",

	---------------------------------------------------------
	-- On-Screen Display
	---------------------------------------------------------

	"swayosd-server --style=$HOME/.config/swayosd/style.css --top-margin 0.1",

	---------------------------------------------------------
	-- Display
	---------------------------------------------------------

	"wlsunset -t 3400 -T 4500",

	---------------------------------------------------------
	-- Environment
	---------------------------------------------------------

	"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
}

-------------------------------------------------------------
-- Execute Startup Commands
-------------------------------------------------------------

hl.on("hyprland.start", function()
	for _, command in ipairs(session) do
		hl.exec_cmd(command)
	end
end)

local screenshot = {

	output = "hyprshot -m output --freeze --output-folder " .. constants.screenshotDir,

	region = "hyprshot -m region --freeze --output-folder " .. constants.screenshotDir,
}

-------------------------------------------------------------
-- Screenshot Keybindings
-------------------------------------------------------------

bindExec("", "PRINT", screenshot.output)

bindExec(mods.shift, "PRINT", screenshot.region)

-------------------------------------------------------------
-- Window Behavior
-------------------------------------------------------------

-------------------------------------------------------------
-- Compatibility
-------------------------------------------------------------

hl.window_rule({
	name = "xwayland-video-bridge",

	match = {
		class = "xwaylandvideobridge",
	},

	no_initial_focus = true,
	no_focus = true,
	no_anim = true,
	no_blur = true,
	max_size = { 1, 1 },
	opacity = "0.0 override",
})

-------------------------------------------------------------
-- Floating Applications
-------------------------------------------------------------

hl.window_rule({
	name = "mpvrx",

	match = {
		class = "mpv",
	},

	float = true,
	center = true,
	size = { 1200, 600 },

	opaque = true,
	opacity = "1.0 override",
})

hl.window_rule({
	name = "rofi",

	match = {
		class = "^(rofi)$",
		title = "^(rofi)$",
	},

	float = true,
})

hl.window_rule({
	name = "blueman-manager",

	match = {
		class = "^(blueman-manager)$",
	},

	float = true,
	move = { 975, 38 },
	size = { 935, 665 },
})

hl.window_rule({
	name = "pavucontrol",

	match = {
		class = "^(org.pulseaudio.pavucontrol)$",
	},

	float = true,
	move = { 970, 37 },
	size = { 940, 505 },
})

hl.window_rule({
	name = "xdg-desktop-portal-gtk",

	match = {
		class = "^(xdg-desktop-portal-gtk)$",
	},

	float = true,
	size = { 970, 611 },
})

hl.window_rule({
	name = "dolphin-library",

	match = {
		initial_title = "Library",
	},

	float = true,
	center = true,
	size = { 975, 470 },
})

hl.window_rule({
	name = "stacer",

	match = {
		class = "stacer",
	},

	float = true,
	center = true,
	size = { 845, 575 },
})

-------------------------------------------------------------
-- Browser
-------------------------------------------------------------

hl.window_rule({
	name = "zen-browser",

	match = {
		class = "zen",
	},

	opaque = true,
})

-------------------------------------------------------------
-- Layer Behavior
-------------------------------------------------------------

-------------------------------------------------------------
-- Waybar
-------------------------------------------------------------

hl.layer_rule({
	name = "waybar",

	match = {
		namespace = "waybar",
	},

	blur = true,
	ignore_alpha = 0,
})

-------------------------------------------------------------
-- Logout Dialog
-------------------------------------------------------------

hl.layer_rule({
	name = "logout-dialog",

	match = {
		namespace = "logout_dialog",
	},

	blur = true,
	ignore_alpha = 0,
})

-------------------------------------------------------------
-- System Commands
-------------------------------------------------------------

local system = {
	lock = "hyprlock",

	clipboardHistory = [[cliphist list | rofi -dmenu -p "Clipboard" -i -theme ~/.config/rofi/clipboard/theme.rasi | cliphist decode | wl-copy]],

	powerMenu = [[ rofi -show p -modi p:'rofi-power-menu --choices=shutdown/reboot/logout --symbols-font "Symbol Nerd Font Mono"' -theme ~/.config/rofi/power/theme.rasi]],
}
-------------------------------------------------------------
-- System Keybindings
-------------------------------------------------------------

bindExec(mods.main, "L", system.lock)

bindExec(mods.alt, "V", system.clipboardHistory)

-- bindExec(mods.main, "X", system.powerMenu)
