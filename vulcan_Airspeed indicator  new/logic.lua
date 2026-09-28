--- vulcan ASI -----

img_add_fullscreen("Vulcan_Air_Back.png")
--img_night = img_add("asi back night.png", 0,0,400,400)
needle = img_add_fullscreen("Vulcan_AirSpeed_Needle.png")
--needle_1 = img_add_fullscreen("needle_small.png")

---------------
-- Functions --
---------------

function new_speed(speed)

       if speed < 261 then
        
        speed = var_cap(speed, 50, 260)
        
	h = (speed - 40)  * 1.56521739
        img_rotate(needle, h) 
       elseif speed < 301 then
       speed = var_cap(speed, 260, 300)
       	h = (speed - 40)  * 1.55
        img_rotate(needle, h)
       elseif speed < 351 then
       speed = var_cap(speed, 300, 350)
       	h = (speed - 40)  * 1.52
        img_rotate(needle, h)       
       elseif speed < 401 then
       speed = var_cap(speed, 350, 400)
       	h = (speed - 40)  * 1.47
        img_rotate(needle, h)  
    end       
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