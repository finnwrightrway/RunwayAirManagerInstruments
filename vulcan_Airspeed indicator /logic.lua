--- vulcan ASI -----

img_add_fullscreen("asi_back.png")
img_night = img_add("asi back night.png", 0,0,400,400)
needle = img_add_fullscreen("needle.png")
needle_1 = img_add_fullscreen("needle_small.png")

---------------
-- Functions --
---------------

function new_speed(speed)

speed = var_cap(speed, 0, 600)
	
    
    t = (speed / 100) * 36
        img_rotate(needle_1, t) 
	
	h = speed * 3.6
        img_rotate(needle, h) 

end

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

-------------------
-- Bus subscribe --
-------------------
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT", new_speed)
fsx_variable_subscribe("AIRSPEED INDICATED", "knots", new_speed)

fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	