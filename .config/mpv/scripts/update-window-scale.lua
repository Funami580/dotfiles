mp.add_periodic_timer(0.001, function()
    local real_scale = mp.get_property_number("current-window-scale")
    local curr_scale = mp.get_property_number("window-scale")
    
    if real_scale == nil then
        return
    end
    
    if curr_scale == nil then
        curr_scale = 1
    end
    
    local multiplier = real_scale / curr_scale
    
    if multiplier > 1.075 or multiplier < 0.925 then
        mp.command("no-osd set window-scale "..real_scale)
    end
end)