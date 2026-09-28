--     Vulcan Radio altimeter    --
-------------------------------------
-- Load and display map and images --
-------------------------------------
img_add_fullscreen("rad_alt_back.png")
--img_night = img_add("rad_alt_back_night.png", 0,0,400,400)
img_zero = img_add("rad_alt_zero.png", 0,0,400,400)
img_zero_night = img_add("rad_alt_zero_night.png", 0,0,400,400)
needle = img_add_fullscreen("rad_alt_needle.png")

-- DEFAULT VISIBILITY --
visible(img_zero, false)
visible(img_zero_night, false)

---------------
-- Functions --
---------------

function new_radalt(altitude,smoking,belts)
       if belts < 1 then
           img_rotate(needle, 1) 
   elseif smoking < 1 then     
        radalt = var_cap(altitude, 0,500)
        img_rotate(needle, radalt * 320 / 500)
   else 
        radalt_new = var_cap(altitude, 0,5000)
        img_rotate(needle, radalt_new * 320 / 5000)    
              
end
	
	 visible(img_zero, smoking)
	
	
end

function xpl_radalt(altitude,switch)
       if switch[24] < 1 then
           img_rotate(needle, 1) 
   elseif switch[26] < 1 then     
        radalt_new = var_cap(altitude, 0,5000)
        img_rotate(needle, radalt_new * 320 / 5000)  
   else 
        radalt = var_cap(altitude, 0,500)
        img_rotate(needle, radalt * 320 / 500)          
end
	
	 visible(img_zero, switch[26] < 1.5)
	
	
end 

function light_fsx(lightpanel,altitude )

      visible(img_night, lightpanel)
	--  visible(img_zero_night, lightpanel, altitude > 501)
	  
end
--end
-------------------
-- Bus subscribe --
-------------------

fsx_variable_subscribe("RADIO HEIGHT", "FEET",
                       "CABIN NO SMOKING ALERT SWITCH", "number",
                       "CABIN SEATBELTS ALERT SWITCH", "number",
                       new_radalt)

xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot", "FLOAT", "thranda/SwitchMonitor", "FLOAT[161]", xpl_radalt)																								
						
fsx_variable_subscribe("LIGHT PANEL", "bool",
                       "RADIO HEIGHT", "FEET",
					   light_fsx)		

---KEY_TOGGLE_LOGO_LIGHTS
---LIGHT LOGO