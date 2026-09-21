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

function bombs(bomb_doors) --check rheomon values
    if bomb_doors == 1 then
        hw_led_set(bomb_slant, 1)
        timer_start(3000)
        hw_led_set(bomb_white, 1)
 
    elseif bomb_doors == 0 then
        hw_led_set(bomb_white, 0)
        hw_led_set(bomb_slant, 1)
        timer_start(3000)
        hw_led_set(bomb_slant, 1)
    else    
        hw_led_set(bomb_white,0)
        hw_led_set(bomb_slant, 0)
    end
end

function feel(eng)
    if (eng[1] and eng[2] and eng[3] and eng[4]) > 22 then
        hw_led_set(feel_on, 1)
        hw_led_set(feel_off, 0)
    elseif (eng[1] or eng[2] or eng[3] or eng[4]) > 22 then    
        hw_led_set(feel_off, 1)
        hw_led_set(feel_on, 0)
    else
        hw_led_set(feel_on, 0)
        hw_led_set(feel_off, 0)
    end
end
        
function cfeed(switch)
    if switch == 1 then
        hw_led_set(cfeed_open,1)
        hw_led_set(cfeed_closed, 0)
    else
        hw_led_set(cfeed_open,0)
        hw_led_set(cfeed_closed, 1) 
    end  
 end    
-------------------
-- Bus subscribe -- FIX
-------------------
xpl_dataref_subscribe("sim/cockpit2/controls/speedbrake_ratio", "FLOAT", air_brake) --check ratio
xpl_dataref_subscribe("thranda/rheostat/rheomonitor[21]", "FLOAT", bombs) --fix this with correct rheomonitor
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/N1_percent", "FLOAT[16]", feel) --test
xpl_dataref_subscribe("thranda/switches/switchmonitor[1]", "FLOAT", cfeed) --fix this with correct switchmonitor