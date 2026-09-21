--       Vulcan Air Lights      --
-------------------------------------
--     Add lights     --
-------------------------------------

ALeds = hw_led_add("ARDUINO_UNO_B_D3", 0.0)
RLeds = hw_led_add("ARDUINO_UNO_B_D4", 0.0)
ELeds = hw_led_add("ARDUINO_UNO_B_D5", 0.0)
Extras = hw_led_add("ARDUINO_UNO_B_D2", 0.0)


---------------
-- Functions --
---------------
function A(leds)
        hw_led_set(ALeds, 0)
end

function R(leds)
        hw_led_set(RLeds, 0)
end

function E(leds)
        hw_led_set(ELeds, 0)
end
function On(leds)
        hw_led_set(ALeds, 1)
        hw_led_set(RLeds, 1)
        hw_led_set(ELeds, 1)
        hw_led_set(Extras,1)
end

-------------------
-- Add Buttons -- 
-------------------


Abutt = hw_button_add("ARDUINO_UNO_B_D10", A)
Rbutt = hw_button_add("ARDUINO_UNO_B_D9", R)
Ebutt = hw_button_add("ARDUINO_UNO_B_D8", E)
Reset = hw_button_add("ARDUINO_UNO_B_D11", On)



-------------------
-- Bus subscribe (Empty as this doesnt talk to the sim) --
-------------------