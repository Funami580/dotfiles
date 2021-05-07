local msg = require 'mp.msg'

function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    
    local t = {}
    
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    
    return t
end

function startswith(inputstr, prefix)
   return inputstr:sub(1, string.len(prefix)) == prefix
end

function endswith(inputstr, suffix)
    return inputstr:sub(-string.len(suffix)) == suffix
end

function get_profiles()
    local profiles = mp.get_property_native("profile-list")
    local user_profiles = {}
    
    for i, v in ipairs(profiles) do
        if v["name"] == "enc-to-hp-slate-7" then
            break
        end
        
        table.insert(user_profiles, v["name"])
    end
    
    return user_profiles
end

local profiles = get_profiles()
local profiles_len = #profiles
local curr_profile = profiles[1]  -- TODO: find curr_profile / currently: last profile defined in mpv.conf

function unload_profile(name)
    local profile_list = mp.get_property_native("profile-list")
    local sub_profiles = {}
    
    for _, profile in pairs(profile_list) do
        if profile["name"] == name then
            local options = profile["options"]
            
            for _, option in pairs(options) do
                local key = option["key"]
                local val = option["value"]
                
                if key == "profile" then
                    for _, sub_profile in pairs(split(val, ",")) do
                        table.insert(sub_profiles, sub_profile)
                    end
                else
                    local default = mp.get_property("option-info/"..key.."/default-value")
                    
                    if key == "dscale" then
                        default = mp.get_property("option-info/scale/default-value")
                    end
                    
                    if endswith(key, "-set") or endswith(key, "-append") or endswith(key, "-add") or endswith(key, "-pre") or endswith(key, "-remove") or endswith(key, "-del") or endswith(key, "-toggle") then
                        if startswith(key, "vf-") or startswith(key, "af-") then
                            local split_key = split(key, "-")
                            local key_first = split_key[1]
                            
                            table.remove(split_key, 1)
                            
                            local key_second = table.concat(split_key, "-")
                            
                            if key_second == "append" or key_second == "add" or key_second == "pre" then
                                key_second = "remove"
                            elseif key_second == "remove" then
                                key_second = "append"
                            elseif key_second == "toggle" then
                                -- change nothing here
                            else
                                msg.error("Couldn't process list command: "..key) -- TODO: -del and -clr not implemented
                            end
                            
                            mp.command("no-osd "..key_first.." "..key_second.." "..val)
                        else
                            msg.error("Couldn't process list command: "..key) -- TODO: Can somebody help me with this / how to execute demuxer-lavf-o-toggle=fflags=+nobuffer via lua?
                        end
                    elseif default == nil or default == "" then
                        msg.error("Empty default value for "..key)
                    else
                        mp.command("no-osd set "..key.." "..default)
                    end
                end
            end
            
            break
        end
    end
    
    for _, sub_profile in pairs(sub_profiles) do
        unload_profile(sub_profile)
    end
end

function load_next_profile(reversed)
    local curr_index = -1
    
    for i, profile in ipairs(profiles) do
        if profile == curr_profile then
            curr_index = i
        end
    end
    
    if curr_index == -1 then
        return
    end
    
    local add = -1
    
    if reversed then
        add = 1
    end
    
    local next_index = curr_index + add
    
    if next_index < 1 then
        next_index = #profiles
    end
    
    if next_index > #profiles then
        next_index = 1
    end
    
    unload_profile(curr_profile)
    local next_profile = profiles[next_index]
    
    mp.command("apply-profile " .. next_profile)
    mp.command("show-text \"Profile: " .. next_profile .. "\"")
    
    curr_profile = next_profile
end

mp.add_key_binding("p", "profile-cycle", function()
    load_next_profile(false)
end)

mp.add_key_binding("P", "profile-cycle-reversed", function()
    load_next_profile(true)
end)