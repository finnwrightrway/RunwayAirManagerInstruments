state_c = 0
state_f = 0
function turn_capt(direction)
    if state_c == 1 then
        if direction == 1 then
            xpl_command("sim/radios/obs1_up")
        end
        if direction == -1 then
            xpl_command("sim/radios/obs1_down")
        end               
    else          
        if direction == 1 then
            xpl_command("sim/autopilot/heading_up") --check
        end
        if direction == -1 then
            xpl_command("sim/autopilot/heading_down") --check
        end
    end             
end
function button_capt()
    if state_c == 1 then
            state_c = 0
    else
            state_c = 1
    end    
end

function turn_fo(direction)
    if state_f == 1 then
        if direction == 1 then
            xpl_command("sim/radios/obs2_up")
        end
        if direction == -1 then
            xpl_command("sim/radios/obs2_down")
        end               
    else          
        if direction == 1 then
            xpl_command("sim/autopilot/heading_copilot_up") --check
        end
        if direction == -1 then
            xpl_command("sim/autopilot/heading_copilot_down") --check
        end
    end             
end
function button_fo()
    if state_f == 1 then
            state_f = 0
    else
            state_f = 1
    end    
end

hw_dial_add("ARDUINO_NANO_C_D3", "ARDUINO_NANO_C_D4", turn_capt)
hw_button_add("ARDUINO_NANO_C_D5", button_capt)
hw_dial_add("ARDUINO_NANO_C_D6", "ARDUINO_NANO_C_D7", turn_fo)
hw_button_add("ARDUINO_NANO_C_D8", button_fo)


--xpl_dataref_subscribe("thranda/OBSButtonThing", "INT", turn)
--xpl_dataref_subscribe("thranda/OBSButtonThing", "INT", button)