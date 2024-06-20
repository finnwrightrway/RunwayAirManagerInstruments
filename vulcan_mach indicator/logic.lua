-- vulcan mach indicator --

img_add_fullscreen( "mach_back.png" )
img_night = img_add("mach_back_night.png", 0,0,400,400)
needle = img_add( "mach_hand.png", 0, 0, 400, 400 )
img_rotate(needle, 20 )

---------------
-- Functions --
---------------

function new_speed(speed)

        speed = var_cap(speed, 0.7, 1.3)
	
        img_rotate(needle, (speed * 320 / .6) + 5.2 ) 
		
end

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

-------------------
-- Bus subscribe --
-------------------

fsx_variable_subscribe("AIRSPEED MACH", "Mach", new_speed)

fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	