local is_enabled = false

mp.add_key_binding("INS", "osc-cycle-chapter", function()
    is_enabled = not is_enabled
    mp.command("script-message osc-chapterlist " .. (is_enabled and 31557600 or 0))
end)