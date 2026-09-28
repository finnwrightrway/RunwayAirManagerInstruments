-- vulcan bottom right fuel

-- Add images --
img_add_fullscreen("fuel bottom back.png")
img_night = img_add("fuel bottom back night.png", 0,0,300,300)
img_needle = img_add("fuel bottom needle.png",0,0,300,300)

function new_fuel_fsx(gallons_center1)

 angle = gallons_center1
 img_rotate(img_needle,  (205 / 3133 * angle) )

end


function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

-- Subscribe to data --

fsx_variable_subscribe("FUEL TANK CENTER2 QUANTITY", "Gallons", 
new_fuel_fsx)

fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	
