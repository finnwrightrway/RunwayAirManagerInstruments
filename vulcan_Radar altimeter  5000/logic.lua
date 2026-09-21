--     Vulcan Radio altimeter    --
-------------------------------------
-- Load and display map and images --
-------------------------------------
img_add_fullscreen("rad_alt_back.png")
img_night = img_add("rad_alt_back_night.png", 0,0,400,400)
img_zero = img_add("rad_alt_zero.png", 0,0,400,400)
img_zero_night = img_add("rad_alt_zero_night.png", 0,0,400,400)
needle = img_add_fullscreen("rad_alt_needle.png")

-- DEFAULT VISIBILITY --
visible(img_zero, false)
visible(img_zero_night, false)

---------------
-- Functions --
---------------

function new_radalt(altitude)
	
	radalt = var_cap(altitude, 0,500)
	img_rotate(needle, radalt * 320 / 500)
end

function new_radalt_high(altitude, lightlogo)
    if lightlogo==1 then
	radalt = var_cap(altitude, 0,5000)
	 img_rotate(needle, radalt * 320 / 5000)
    end
	
--- are we above 500 feet ---	
	 visible(img_zero, altitude > 501)
	
end 

function light_fsx(lightpanel,altitude )

      visible(img_night, lightpanel)
	--  visible(img_zero_night, lightpanel, altitude > 501)
	  
end

-------------------
-- Bus subscribe --
-------------------

fsx_variable_subscribe("RADIO HEIGHT", "FEET",
                        new_radalt)
						
fsx_variable_subscribe("RADIO HEIGHT", "FEET",
                       "LIGHT LOGO", "bool",
                        new_radalt_high)						
						
fsx_variable_subscribe("LIGHT PANEL", "bool",
                       "RADIO HEIGHT", "FEET",
					   light_fsx)		

---KEY_TOGGLE_LOGO_LIGHTS
---LIGHT LOGO