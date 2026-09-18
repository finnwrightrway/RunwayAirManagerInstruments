--       Vulcan Panel Lights      --
-------------------------------------
--     Add lights     --
-------------------------------------

Fuel1 = hw_led_add("ARDUINO_MEGA2560_A_D42", 0.0)
Fuel2 = hw_led_add("ARDUINO_MEGA2560_A_D40", 0.0)
Fuel3 = hw_led_add("ARDUINO_MEGA2560_A_D38", 0.0)
Fuel4 = hw_led_add("ARDUINO_MEGA2560_A_D36", 0.0)

ledarray = {Fuel1, Fuel2, Fuel3, Fuel4}

Escape = hw_led_add("ARDUINO_UNO_B_D6", 0.0)
TFR_Vid = hw_led_add("ARDUINO_UNO_B_D12", 0.0)
TFR_Warn = hw_led_add("ARDUINO_UNO_B_D13", 0.0)

Main = hw_led_add("ARDUINO_MEGA2560_A_D34", 0.0)
AP = hw_led_add("ARDUINO_MEGA2560_A_D32", 0.0)
Alt_Fail = hw_led_add("ARDUINO_MEGA2560_A_D30", 0.0)
Canopy = hw_led_add("ARDUINO_MEGA2560_A_D28", 0.0)
Pitot = hw_led_add("ARDUINO_MEGA2560_A_D26", 0.0)
Door = hw_led_add("ARDUINO_MEGA2560_A_D24", 0.0)
Park = hw_led_add("ARDUINO_MEGA2560_A_D22", 0.0)

---------------
-- Functions -- FIX
---------------
function fuel(fuel_press)
    for i = 1,4 do
    
        if fuel_press[i] == 100 then
            hw_led_set(ledarray[i], 0)
    
        elseif  fuel_press[i] > 15 then
            hw_led_set(ledarray[i], 1)
            timer_start(500)
            hw_led_set(ledarray[i], 0)
            timer_start(500)
        
        else
            hw_led_set(ledarray[i], 1)    
        
        end
    end
end

function gear_lights_n(gear_N)

    if gear_N == 1 then
        hw_led_set(Escape, 0)
    elseif gear_N < 1 and gear_N > 0 then
        hw_led_set(Escape,0)
    else    
         hw_led_set(Escape,1)
    end
end
function pause(pause)
    if pause == 0 then
        hw_led_set(Door, 0)
    else
        hw_led_set(Door, 1)
    end
end
   
function park(brake)
    if brake == 0 then
        hw_led_set(Park, 0)
    else
        hw_led_set(Park, 1)
    end
end           
    
-------------------
-- Bus subscribe -- FIX
-------------------
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/fuel_pressure_psi", "FLOAT[16]", fuel)
xpl_dataref_subscribe("sim/flightmodel/movingparts/gear1def", "FLOAT", gear_lights_n)
xpl_dataref_subscribe("sim/cockpit2/controls/parking_brake_ratio", "FLOAT", park)
xpl_dataref_subscribe("sim/time/paused", "BOOL", pause)