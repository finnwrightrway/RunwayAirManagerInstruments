-- vulcan adf --

img_add_fullscreen("adf_back.png")
img_night = img_add("adf back night.png", 0,0,400,400)
--yellow_needle = img_add_fullscreen("adf_hand_yellow.png")
white_needle = img_add_fullscreen("adf_hand_white.png")


function new_adf(adfwhite)
	
		if adfwhite > 89.5 and adfwhite < 90.5 then
		img_rotate(white_needle, adfwhite )
	else
		img_rotate(white_needle, adfwhite )
	end
	
end

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

xpl_dataref_subscribe("sim/cockpit/radios/adf1_cardinal_dir", "FLOAT",
			  "sim/cockpit2/radios/indicators/adf1_relative_bearing_deg", "FLOAT", new_adf)
fsx_variable_subscribe("ADF RADIAL:1", "Degrees", 
                       new_adf)	

fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	   