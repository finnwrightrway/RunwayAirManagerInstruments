--     Vulcan Radio altimeter    --

img_add_fullscreen("rad_alt_back.png")
--img_night = img_add("rad_alt_back_night.png", 0,0,400,400)
needle = img_add_fullscreen("rad_alt_needle.png")

---------------
-- Functions --
---------------

function new_radalt_FSX(altitude)
	
	radalt = var_cap(altitude, 0,500)
	img_rotate(needle, radalt * 320 / 500)
end

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end


-------------------
-- Bus subscribe --
-------------------

fsx_variable_subscribe("RADIO HEIGHT", "FEET",
                        new_radalt_FSX)
						
-- This is where we check if the backlight (cockpit light) is on, currently disabled, re-enable when req, and set up for x-plane --

-- fsx_variable_subscribe("LIGHT PANEL", "bool",
--				   light_fsx)						