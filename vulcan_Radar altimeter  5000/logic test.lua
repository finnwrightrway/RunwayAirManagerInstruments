--     Vulcan Radio altimeter    --
-------------------------------------
-- Load and display map and images --
-------------------------------------
img_add_fullscreen("rad_alt_back.png")
needle = img_add_fullscreen("rad_alt_needle.png")
img_zero = img_add_fullscreen("rad_alt_zero.png")

-- DEFAULT VISIBILITY --
visible(img_zero, false)

---------------
-- Functions --
---------------



function new_radalt(altitude, bug, power, test)

	radalt = var_cap(altitude, 0,5000)
	
	if altitude <= 500 then 
	   img_rotate(needle, radalt * 320 / 500)
	     elseif altitude >= 501 then 
	        img_rotate(needle, radalt * 320 / 5000)
    end
	
	-- Are we above 500 feet ----
	visible(img_zero, light_logo == 0)
	
	
end 




function new_radalt_FSX(altitude)
	
	new_radalt(altitude)
	
end

-------------------
-- Bus subscribe --
-------------------

fsx_variable_subscribe("RADIO HEIGHT", "FEET",
                       "LIGHT LOGO", "Bool",
                        new_radalt_FSX)