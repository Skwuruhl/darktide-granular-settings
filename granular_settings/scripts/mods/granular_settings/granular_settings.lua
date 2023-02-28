local mod = get_mod("granular_settings")

local OptionsUtilities = require("scripts/utilities/ui/options")

mod:hook(OptionsUtilities, "create_value_slider_template", function(func, params)
    if params.id == "mouse_look_scale" then
        params.min_value = 0.01
        params.num_decimals = 2
        params.step_size_value = 0.01
    end
    return func(params)
end)

mod:hook_require("scripts/settings/options/render_settings", function(instance)
    for i, v in ipairs(instance.settings) do
        if v.id == "gameplay_fov" then
            v.num_decimals = 1
            v.step_size_value = 0.1
            v.min_value = v.min_value + 20
            v.max_value = v.max_value + 20
        end
    end
end)
