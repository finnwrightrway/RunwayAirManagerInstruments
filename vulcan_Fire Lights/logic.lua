--       Vulcan Fire Lights      --
-------------------------------------
--     Add lights     --
-------------------------------------

Fire1 = hw_led_add("ARDUINO_MEGA2560_A_D18", 0.0)
Fire2 = hw_led_add("ARDUINO_MEGA2560_A_D19", 0.0)
Fire3 = hw_led_add("ARDUINO_MEGA2560_A_D20", 0.0)
Fire4 = hw_led_add("ARDUINO_MEGA2560_A_D21", 0.0)

ledarray = {Fire1, Fire2, Fire3, Fire4}

---------------
-- Functions --
---------------

function fire(onfire)
    for i = 1,4 do
        if onfire[i] == 1 then
            hw_led_set(ledarray[i], 1)
        else
            hw_led_set(ledarray[i], 0)
     end               
   end
end

-------------------
-- Bus subscribe --
-------------------
xpl_dataref_subscribe("sim/flightmodel2/engines/is_on_fire", "FLOAT[16]", fire)
