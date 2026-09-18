--       Vulcan Mag Indicators      --
-------------------------------------
--     Add lights     --
-------------------------------------

air_slant = hw_led_add("ARDUINO_MEGA2560_A_D5", 0.0)
air_white = hw_led_add("ARDUINO_MEGA2560_A_D6", 0.0)

bomb_slant = hw_led_add("ARDUINO_MEGA2560_A_D7", 0.0)
bomb_white = hw_led_add("ARDUINO_MEGA2560_A_D8", 0.0)

feel_off = hw_led_add("ARDUINO_MEGA2560_A_D9", 0.0)
feel_on = hw_led_add("ARDUINO_MEGA2560_A_D10", 0.0)

cfeed_open = hw_led_add("ARDUINO_MEGA2560_A_D11", 0.0)
cfeed_closed = hw_led_add("ARDUINO_MEGA2560_A_D12", 0.0)

---------------
-- Functions -- FIX
---------------
function air_brake(airbrake)
    if airbrake > 1 then
        hw_led_set(air_slant, 1)
 
    elseif airbrake < 1 and airbrake > 0 then
        hw_led_set(air_white,1)
        hw_led_set(air_slant, 0)
    else    
        hw_led_set(air_white,0)
        hw_led_set(air_slant, 0)
    end
end

-------------------
-- Bus subscribe -- FIX
-------------------
xpl_dataref_subscribe("sim/flightmodel/movingparts/gear2def", "FLOAT", gear_lights_l)
xpl_dataref_subscribe("sim/flightmodel/movingparts/gear3def", "FLOAT", gear_lights_r)
xpl_dataref_subscribe("sim/flightmodel/movingparts/gear1def", "FLOAT", gear_lights_n)