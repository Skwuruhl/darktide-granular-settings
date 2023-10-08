local mod = get_mod("granular_settings")

local OptionsUtilities = require("scripts/utilities/ui/options")
local SettingsUtilities = require("scripts/ui/views/first_run_settings_view/utils")

mod:hook(OptionsUtilities, "create_value_slider_template", function(func, params)
    if params.id == "mouse_look_scale" or params.id == "mouse_look_scale_ranged" or params.id == "mouse_look_scale_ranged_alternate_fire" then
        params.min_value = 0
        params.max_value = 10
        params.num_decimals = 6
        params.step_size_value = 10 ^ (-1*params.num_decimals)
    end
    return func(params)
end)

mod:hook_require("scripts/settings/options/render_settings", function(instance)
    for i, v in ipairs(instance.settings) do
        if v.id == "gameplay_fov" then
            v.num_decimals = 6
            v.step_size_value = 10 ^ (-1*v.num_decimals)
            v.min_value = v.step_size_value
            v.max_value = 180 - v.step_size_value
        end
    end
end)

mod:command("set_look_scale", mod:localize("sensitivity_description"), function(s, ...)
    s = tonumber(s)
    if s == nil then
        mod:error("Invalid")
        return
    end
    SettingsUtilities.save_account_settings("input_settings", "mouse_look_scale", s)
    SettingsUtilities.save_account_settings("input_settings", "mouse_look_scale_ranged", s)
    SettingsUtilities.save_account_settings("input_settings", "mouse_look_scale_ranged_alternate_fire", s)
end)

mod:command("set_look_scale_ranged", mod:localize("sensitivity_description"), function(s, ...)
    s = tonumber(s)
    if s == nil then
        mod:error("Invalid")
        return
    end
    SettingsUtilities.save_account_settings("input_settings", "mouse_look_scale_ranged", s)
end)

mod:command("set_look_scale_ranged_alternate_fire", mod:localize("sensitivity_description"), function(s, ...)
    s = tonumber(s)
    if s == nil or s < 0 or s > 10 then
        mod:error("Invalid")
        return
    end
    SettingsUtilities.save_account_settings("input_settings", "mouse_look_scale_ranged_alternate_fire", s)
end)

mod:command("set_vertical_fov", mod:localize("fov_description"), function(f, ...)
    f = tonumber(f)
    if f == nil or f <= 0 or f >= 180 then
        mod:error("Invalid")
        return
    end
    Application.set_user_setting("render_settings", "vertical_fov", f)
    local camera_manager = rawget(_G, "Managers") and Managers.state.camera

		if camera_manager then
			local fov_multiplier = f / DefaultGameParameters.vertical_fov

			camera_manager.set_fov_multiplier(camera_manager, fov_multiplier)
		end
end)

mod:command("set_horizontal_fov", mod:localize("fov_description"), function(f, ...)
    f = tonumber(f)
    if f == nil or f <= 0 or f >= 180 then
        mod:error("Invalid")
        return
    end
    
    local aspect_ratio = RESOLUTION_LOOKUP.width / RESOLUTION_LOOKUP.height
    local f = 2 * math.deg(math.atan(math.tan(math.rad(f/2)) / aspect_ratio))

    Application.set_user_setting("render_settings", "vertical_fov", f)
    local camera_manager = rawget(_G, "Managers") and Managers.state.camera
    if camera_manager then
        local fov_multiplier = f / DefaultGameParameters.vertical_fov

        camera_manager:set_fov_multiplier(fov_multiplier)
    end
end)
