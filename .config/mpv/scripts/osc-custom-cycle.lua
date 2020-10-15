local is_auto = true  -- no way to read the osc mode, so we assume it starts in auto mode.

mp.add_key_binding("h", "osc-cycle-never-auto", function()
    is_auto = not is_auto
    mp.command("script-message osc-visibility " .. (is_auto and "auto" or "never"))
end)

mp.add_key_binding("", "osc-cycle-never-auto-no-osd", function()
    is_auto = not is_auto
    mp.command("script-message osc-visibility " .. (is_auto and "auto" or "never") .. " no-osd")
end)

mp.add_key_binding("", "osc-cycle-auto-no-osd", function()
    is_auto = true
    mp.command("script-message osc-visibility auto no-osd")
end)

mp.add_key_binding("", "osc-cycle-never-no-osd", function()
    is_auto = false
    mp.command("script-message osc-visibility never no-osd")
end)