-- vulcan top right fuel

-- Add images --
img_add_fullscreen("fuel top back.png")
img_night = img_add("fuel top back night.png", 0,0,300,300)
img_needle = img_add("fuel top needle.png",0,0,300,300)

function new_fuel_fsx(gallons_right)

 angle = gallons_right
 img_rotate(img_needle,(240 / 3200 * angle) )

end


function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

-- Subscribe to data --

fsx_variable_subscribe("FUEL RIGHT QUANTITY", "Gallons", 
new_fuel_fsx)

fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	
