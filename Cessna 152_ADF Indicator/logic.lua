-- Add images in Z-order --
img_add_fullscreen("casing.png")
rose = img_add("dial.png", 56, 56, 400, 400)
adf_needle = img_add("needle.png", 226, 106, 60, 300)
img_add("ring.png", 32, 32, 448, 448)
img_add("glass.png", 28, 28, 456, 456)
img_add("hdg.png", 10, 390, 121, 121)

-- Functions --
function PT_adf(heading, adfgreen)
    
    rotate(rose, heading* -1)
    
    if adfgreen > 89.5 and adfgreen < 90.5 then
        rotate(adf_needle, 90)
    else
        rotate(adf_needle, adfgreen)
    end    
    
end

dial_add("hdg_dial.png", 10, 390, 121, 121, function(direction)

    if direction == -1 then
        fsx_event("ADF_CARD_DEC")
        fs2020_event("ADF_CARD_DEC")
        xpl_command("sim/radios/adf1_card_down")
    else
        fsx_event("ADF_CARD_INC")
        fs2020_event("ADF_CARD_INC")
        xpl_command("sim/radios/adf1_card_up")
    end

end)

-- Bus subscribe --
xpl_dataref_subscribe("sim/cockpit/radios/adf1_cardinal_dir", "FLOAT",
                      "sim/cockpit2/radios/indicators/adf1_relative_bearing_deg", "FLOAT", PT_adf)
fsx_variable_subscribe("ADF CARD", "Degrees",
                       "ADF RADIAL:1", "Degrees",
                       "ADF RADIAL:2", "Degrees", PT_adf)
fs2020_variable_subscribe("ADF CARD", "Degrees",
                          "ADF RADIAL:1", "Degrees",
                          "ADF RADIAL:2", "Degrees", PT_adf)                       