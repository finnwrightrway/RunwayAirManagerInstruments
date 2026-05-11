------------------------------------
----vulcan distance----
------------------------------------

-- Add images and text --
img_add_fullscreen("vor_distance.png")
--img_night = img_add("vor_distance_night.png", 0,0,250,250)
needle = img_add("vor_needle.png", 0,0,250,250)


-- Functions --
function new_data_fsx(dist1)

    	dist1 = var_cap(dist1, 0,20)
	
	img_rotate(needle, dist1 * 9)

end

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

fsx_variable_subscribe("NAV DME:1", "NAUTICAL MILES", 
					    new_data_fsx)					  

xpl_dataref_subscribe("sim/cockpit/radios/adf1_dme_dist_m","FLOAT",new_data_fsx)
					  					  					  
-- This is where we check if the backlight (cockpit light) is on, currently disabled, re-enable when req, and set up for x-plane --

-- fsx_variable_subscribe("LIGHT PANEL", "bool",
--				   light_fsx)	