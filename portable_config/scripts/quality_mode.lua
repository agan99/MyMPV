local modes = {
    original = {},
    cinema = {"shaders/FSRCNNX/FSRCNNX_x2_2_12_0_3_1_v1_fastv2.glsl"},
    anime = {
        "shaders/Anime4K/Anime4K_Restore_CNN_Soft_S.glsl",
        "shaders/Anime4K/Anime4K_Upscale_CNN_x2_S.glsl",
    },
}

local function set_mode(name)
    local files = modes[name]
    if not files then
        mp.msg.error("Unknown quality mode: " .. tostring(name))
        return
    end
    local paths = {}
    for _, file in ipairs(files) do
        local path = mp.find_config_file(file)
        if not path then
            mp.msg.error("Missing shader: " .. file)
            mp.osd_message("MyMPV: missing shader")
            return
        end
        paths[#paths + 1] = path
    end
    mp.set_property_native("glsl-shaders", paths)
    mp.osd_message("MyMPV: " .. name)
end

mp.register_script_message("mympv-quality", set_mode)
mp.register_event("start-file", function() set_mode("original") end)
