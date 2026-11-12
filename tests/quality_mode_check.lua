local expected = {
    {"cinema", 1},
    {"anime", 2},
    {"original", 0},
}

mp.register_event("file-loaded", function()
    local function check(index)
        local test = expected[index]
        if not test then
            mp.msg.info("QUALITY_MODE_CHECK_PASSED")
            return
        end
        mp.commandv("script-message", "mympv-quality", test[1])
        mp.add_timeout(0.25, function()
            local shaders = mp.get_property_native("glsl-shaders")
            assert(#shaders == test[2], test[1] .. ": expected " .. test[2] .. " shaders, got " .. #shaders)
            check(index + 1)
        end)
    end
    check(1)
end)
