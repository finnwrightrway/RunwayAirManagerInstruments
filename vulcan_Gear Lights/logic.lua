--       Vulcan Gear Lights      --
-------------------------------------
--     Add lights     --
-------------------------------------

gear_l_red = hw_led_add("gearLRed", 0.0)
gear_r_red = hw_led_add("gearRRed", 0.0)
gear_n_red = hw_led_add("gearNRed", 0.0)

gear_l_green = hw_led_add("gearLGreen", 1)
gear_r_green = hw_led_add("gearRGreen", 1)
gear_n_green = hw_led_add("gearNGreen", 1)


---------------
-- Functions --
---------------
function gear_lights_l(gear_L)
    if gear_L == 1 then
        hw_led_set(gear_l_green, 1)
        hw_led_set(gear_l_red, 0)
    elseif gear_L < 1 and gear_L > 0 then
        hw_led_set(gear_l_green,0)
        hw_led_set(gear_l_red, 1)
    else    
         hw_led_set(gear_l_green,0)
        hw_led_set(gear_l_red, 0)
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
-- Bus subscribe --
-------------------
xpl_dataref_subscribe("sim/flightmodel/movingparts/gear2def", "FLOAT", gear_lights_l)
xpl_dataref_subscribe("sim/flightmodel/movingparts/gear3def", "FLOAT", gear_lights_r)
xpl_dataref_subscribe("sim/flightmodel/movingparts/gear1def", "FLOAT", gear_lights_n)