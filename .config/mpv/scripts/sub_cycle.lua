mp.add_key_binding("", "reload_subs_on_pause", function()
    if mp.get_property_bool("pause") == true then
        mp.command("no-osd seek 0 relative+exact")
    end
end)
