return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`granular_settings` encountered an error loading the Darktide Mod Framework.")

		new_mod("granular_settings", {
			mod_script       = "granular_settings/scripts/mods/granular_settings/granular_settings",
			mod_data         = "granular_settings/scripts/mods/granular_settings/granular_settings_data",
			mod_localization = "granular_settings/scripts/mods/granular_settings/granular_settings_localization",
		})
	end,
	packages = {},
}
