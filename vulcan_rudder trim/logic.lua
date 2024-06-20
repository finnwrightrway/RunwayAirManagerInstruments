--- vulcan rudder trim ---

img_add_fullscreen("rudder_trim_back.png")
img_night = img_add("rudder_trim_back_night.png", 0,0,250,250)
needle = img_add_fullscreen("rudder_hand.png")

function PT_trim(rudder)
	rudder = rudder / 50
	img_rotate(needle, rudder * 60)
	
end


function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

fsx_variable_subscribe("RUDDER TRIM PCT", "Percent", 
                       PT_trim)
					   
fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)						   