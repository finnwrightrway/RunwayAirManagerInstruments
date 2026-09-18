--       Vulcan Air Lights      --
-------------------------------------
--     Add lights     --
-------------------------------------

ALeds = hw_led_add("ARDUINO_UNO_B_D3", 0.0)
RLeds = hw_led_add("ARDUINO_UNO_B_D4", 0.0)
ELeds = hw_led_add("ARDUINO_UNO_B_D5", 0.0)
Extras = hw_led_add("ARDUINO_UNO_B_D2", 0.0)

Abutt = hw_button_add("ARDUINO_UNO_B_D10", pressed, released)
Rbutt = hw_button_add("ARDUINO_UNO_B_D9", pressed, released)
Ebutt = hw_button_add("ARDUINO_UNO_B_D8", pressed, released)
Reset = hw_button_add("ARDUINO_UNO_B_D11", pressed, released)


---------------
-- Functions -- FIX
---------------
function fuel(fuel)
    if fuek == 1 then
        hw_led_set(gear_l_green, 1)
    else    
         hw_led_set(gear_l_green,0)

    end
end
function gear_lights_r(gear_R)

    if gear_R == 1 then
        hw_led_set(gear_r_green, 1)
        hw_led_set(gear_r_red, 0)
    elseif gear_R < 1 and gear_R > 0 then
        hw_led_set(gear_r_green,0)
        hw_led_set(gear_r_red, 1)
    else    
         hw_led_set(gear_r_green,0)
        hw_led_set(gear_r_red, 0)
    end
end
function gear_lights_n(gear_N)

    if gear_N == 1 then
        hw_led_set(gear_n_green, 1)
        hw_led_set(gear_n_red, 0)
    elseif gear_N < 1 and gear_N > 0 then
        hw_led_set(gear_n_green,0)
        hw_led_set(gear_n_red, 1)
    else    
         hw_led_set(gear_n_green,0)
        hw_led_set(gear_n_red, 0)
    end
end
-------------------
-- Bus subscribe -- FIX
-------------------
xpl_dataref_subscribe("sim/flightmodel/movingparts/gear2def", "FLOAT", gear_lights_l)
xpl_dataref_subscribe("sim/flightmodel/movingparts/gear3def", "FLOAT", gear_lights_r)
xpl_dataref_subscribe("sim/flightmodel/movingparts/gear1def", "FLOAT", gear_lights_n)