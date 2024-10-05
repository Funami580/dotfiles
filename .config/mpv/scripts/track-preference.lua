local native_langs = {"de", "deu", "ger"}
local native_lang_strings = {"deutsch", "german"}
local audio_langs = {"de", "deu", "ger", "ja", "jp", "jpn", "en", "eng", "enUS"}
local sub_langs = {"de", "deu", "ger", "en", "eng", "enUS"}
local audio_codecs = {"dtshd", "dts", "truehd", "pcm", "flac", "wav", "wv", "ape", "tta", "shn"}

function startswith(inputstr, prefix)
   return inputstr:sub(1, string.len(prefix)) == prefix
end

function best_audio()
    local tracktable = mp.get_property_native("track-list", {})
    local best_audio_track = nil
    
    for _, track in pairs(tracktable) do
        if track.type == "audio" then
            local title = track["title"]
            local lang = track["lang"]
            local codec = track["codec"]
            local visual_impaired = track["visual-impaired"]
            local hearing_impaired = track["hearing-impaired"]
            local num_channels = track["audio-channels"]
            
            if best_audio_track == nil then
                best_audio_track = track
            else
                -- 1st check if impaired or not / prefer non-impaired
                if (visual_impaired == false and best_audio_track["visual-impaired"] == true) or (hearing_impaired == false and best_audio_track["hearing-impaired"] == true) then
                    best_audio_track = track
                elseif visual_impaired == best_audio_track["visual-impaired"] and hearing_impaired == best_audio_track["hearing-impaired"] then
                    -- 2nd check language
                    lang_index_base = nil
                    lang_index_loop = nil
                    
                    for audio_index, audio_lang in pairs(audio_langs) do
                        if lang_index_loop == nil and audio_lang == lang then
                            lang_index_loop = audio_index
                        end
                        
                        if lang_index_base == nil and audio_lang == best_audio_track["lang"] then
                            lang_index_base = audio_index
                        end
                    end
                    
                    for audio_index, audio_lang in pairs(native_lang_strings) do
                        if title ~= nil and string.match(string.lower(title), audio_lang) ~= nil then
                            lang_index_loop = 0
                        end
                    
                        if best_audio_track["title"] ~= nil and string.match(string.lower(best_audio_track["title"]), audio_lang) ~= nil then
                            lang_index_base = 0
                        end
                    end
                    
                    if (lang_index_base == nil and lang_index_loop ~= nil) or (lang_index_base ~= nil and lang_index_loop ~= nil and lang_index_loop < lang_index_base) then
                        best_audio_track = track
                    elseif lang_index_base == lang_index_loop then
                        -- 3rd check for codec / prefer lossless
                        codec_index_base = nil
                        codec_index_loop = nil
                    
                        for codec_index, audio_codec in pairs(audio_codecs) do
                            local pcm_key = "pcm"
                            local pcm_base = false
                            local pcm_loop = false
                            
                            if audio_codec == pcm_key then
                                if startswith(best_audio_track["codec"], pcm_key) then
                                    pcm_base = true
                                end
                                
                                if startswith(codec, pcm_key) then
                                    pcm_loop = true
                                end
                            end
                            
                            if codec_index_loop == nil and (audio_codec == codec or pcm_loop) then
                                codec_index_loop = codec_index
                            end
                        
                            if codec_index_base == nil and (audio_codec == best_audio_track["codec"] or pcm_base) then
                                codec_index_base = codec_index
                            end
                        end
                        
                        if (codec_index_base == nil and codec_index_loop ~= nil) or (codec_index_base ~= nil and codec_index_loop ~= nil and codec_index_loop < codec_index_base) then
                            best_audio_track = track
                        elseif codec_index_base == codec_index_loop then
                            -- 4th check for audio channels / more is better
                            if num_channels > best_audio_track["audio-channels"] then
                                best_audio_track = track
                            end
                        end
                    end
                end
            end
        end
    end
    
    return best_audio_track
end

function best_sub(audio_track)
    if audio_track == nil then
        return nil
    end
    
    local audio_native = false
    
    for _, native_lang in pairs(native_langs) do
        if native_lang == audio_track["lang"] then
            audio_native = true
            break
        end
    end
    
    for _, audio_lang in pairs(native_lang_strings) do
        if audio_track["title"] ~= nil and string.match(string.lower(audio_track["title"]), audio_lang) ~= nil then
            audio_native = true
            break
        end
    end
    
    local tracktable = mp.get_property_native("track-list", {})
    local best_subtitle_track = nil
    local best_subtitle_tracks = {}
    local should_forced = audio_native
    
    for _, track in pairs(tracktable) do
        if track.type == "sub" then
            local title = track["title"]
            local lang = track["lang"]
            local forced = track["forced"]
            local codec = track["codec"]
            local visual_impaired = track["visual-impaired"]
            local hearing_impaired = track["hearing-impaired"]
            
            if best_subtitle_track == nil then
                best_subtitle_track = track
            else
                -- 1st check if impaired or not / prefer non-impaired
                if (visual_impaired == false and best_subtitle_track["visual-impaired"] == true) or (hearing_impaired == false and best_subtitle_track["hearing-impaired"] == true) then
                    best_subtitle_track = track
                    best_subtitle_tracks = {track}
                elseif visual_impaired == best_subtitle_track["visual-impaired"] and hearing_impaired == best_subtitle_track["hearing-impaired"] then
                    -- 2nd check language
                    lang_index_base = nil
                    lang_index_loop = nil
                    
                    for audio_index, sub_lang in pairs(sub_langs) do
                        if lang_index_loop == nil and sub_lang == lang then
                            lang_index_loop = audio_index
                        end
                        
                        if lang_index_base == nil and sub_lang == best_subtitle_track["lang"] then
                            lang_index_base = audio_index
                        end
                    end
                    
                    if (lang_index_base == nil and lang_index_loop ~= nil) or (lang_index_base ~= nil and lang_index_loop ~= nil and lang_index_loop < lang_index_base) then
                        best_subtitle_track = track
                        best_subtitle_tracks = {track}
                    elseif lang_index_base == lang_index_loop then
                        -- 3rd check for forced
                        forced_key = "forced"
                        base_title = best_subtitle_track["title"]
                        loop_title = title
                        
                        if base_title == nil then
                            base_title = ""
                        end
                        
                        if loop_title == nil then
                            loop_title = ""
                        end
                        
                        base_forced = best_subtitle_track["forced"] or (string.match(string.lower(base_title), forced_key) ~= nil)
                        loop_forced = forced or (string.match(string.lower(loop_title), forced_key) ~= nil)
                        
                        if should_forced == loop_forced and should_forced ~= base_forced then
                            best_subtitle_track = track
                            best_subtitle_tracks = {track}
                        elseif loop_forced == base_forced then
                            -- 4th check for codec
                            if (codec == "ass" or codec == "ssa") and (best_subtitle_track["codec"] ~= "ass" and best_subtitle_track["codec"] ~= "ssa") then
                                best_subtitle_track = track
                                best_subtitle_tracks = {track}
                            else
                                table.insert(best_subtitle_tracks, track)
                            end
                        end
                    end
                end
            end
        end
    end
    
    if best_subtitle_track == nil then
        return nil
    end
    
    if should_forced and best_subtitle_track["forced"] == false and #best_subtitle_tracks >= 2 then
        return best_subtitle_tracks[2]
    end
    
    return best_subtitle_track
end

function choose_best_tracks(silent, change_subtitle)
    local audio = best_audio()
    local subtitle = nil

    if change_subtitle then
        subtitle = best_sub(audio)
    end
    
    if audio ~= nil then
        mp.command("no-osd set aid " .. audio["id"])
    end
    
    if subtitle ~= nil then
        mp.command("no-osd set sid " .. subtitle["id"])
    end
    
    if not silent then
        mp.command("show-text \"Checked tracks\"")
    end
end

function choose_best_tracks_silent()
    local is_sub_external = mp.get_property_native("current-tracks/sub/external")
    local change_subtitle = is_sub_external == nil or (is_sub_external ~= nil and is_sub_external == false)
    choose_best_tracks(true, change_subtitle)
end

function choose_best_tracks_non_silent()
    choose_best_tracks(false, true)
end

mp.register_event("file-loaded", choose_best_tracks_silent)
mp.add_key_binding("SHARP", "choose-best-tracks", choose_best_tracks_non_silent)
