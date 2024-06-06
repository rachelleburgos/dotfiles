local wezterm = require("wezterm")

wezterm.on("update-right-status", function(window, pane)
	-- Each element holds the text for a cell in a "powerline" style

	local cells = {}

	-- Figure out the cwd and host of the current pane.
	-- This will pick up the hostname for the remote host if your
	-- shell is using OSC 7 on the remote host.
	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		local cwd = ""
		local hostname = ""

		if type(cwd_uri) == "userdata" then
			-- Running on a newer version of wezterm and we have
			-- a URL object here, making this simple!
			cwd = cwd_uri.file_path
			hostname = cwd_uri.host or wezterm.hostname()
		else
			-- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
			-- which doesn't have the Url object
			cwd_uri = cwd_uri:sub(8)
			local slash = cwd_uri:find("/")
			if slash then
				hostname = cwd_uri:sub(1, slash - 1)
				-- and extract the cwd from the uri, decoding %-encoding
				cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
					return string.char(tonumber(hex, 16))
				end)
			end
		end

		-- Remove the domain name portion of the hostname
		local dot = hostname:find("%[.%]")
		if dot then
			hostname = hostname:sub(1, dot - 1)
		end
		if hostname == "" then
			hostname = wezterm.hostname()
		end

		table.insert(cells, cwd)
		table.insert(cells, hostname)
	end

	-- I like my date/time in this style: "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M")
	table.insert(cells, date)

	-- An entry for each battery (typically 0 or 1 battery)
	for _, b in ipairs(wezterm.battery_info()) do
		table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
	end

	-- The separator
	local separator = " | "

	-- Format the cells with the separator
	local formatted_cells = table.concat(cells, separator)

	window:set_right_status(formatted_cells)
end)

local config = {}
if wezterm.config_builder then
	-- makes nicer error messages for config errors
	config = wezterm.config_builder()
end

config.check_for_updates = true

local scheme = "Black Metal (Dark Funeral) (base16)"
local scheme_def = wezterm.get_builtin_color_schemes()[scheme]
local TRANSPARENT = "rgba(0,0,0,0.85)"

config.selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%"

config.color_scheme = scheme

config.font = wezterm.font("iMWritingMono Nerd Font")
config.font_size = 15

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.85
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 0,
}

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.colors = {
	tab_bar = {
		background = TRANSPARENT,
		new_tab = { bg_color = TRANSPARENT, fg_color = scheme_def.ansi[8], intensity = "Bold" },
		new_tab_hover = { bg_color = scheme_def.ansi[1], fg_color = scheme_def.brights[8], intensity = "Bold" },
		active_tab = { bg_color = TRANSPARENT, fg_color = "#FCE8C3" },
		inactive_tab = { bg_color = TRANSPARENT, fg_color = "#FCE8C3" },
		inactive_tab_hover = { bg_color = scheme_def.background, fg_color = "#FCE8C3" },
	},
}

return config
