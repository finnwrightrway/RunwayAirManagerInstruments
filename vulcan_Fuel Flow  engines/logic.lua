--- vulcan fuel flow engines ----

img_add_fullscreen("fuel flow eng.png")
img_night = img_add("fuel flow eng night.png", 0,0,250,250)
img_needle = img_add("needle outer.png",0,0,250,250)

function PT_fuel_flow_FSX(fuelflow_1, fuelflow_2, fuelflow_3, fuelflow_4)
	
	eng1 = (fuelflow_1)
	eng2 = (fuelflow_2)
	eng3 = (fuelflow_3)
	eng4 = (fuelflow_4)
	PT_fuel_flow( {eng1 + eng2 + eng3 + eng4} )
	
end
	
function PT_fuel_flow(fuelflow)

	  -- angle = var_cap(angle,0,400)
	   -- angle = (fuelflow[1] * 0.36)
		 angle = (fuelflow[1] * 0.51)
		
	  if angle <=101 then
	   img_rotate(img_needle, (angle / 10 ))
	   else 
	   img_rotate(img_needle, (angle /100 ) - 40)
	   end
	      
  end


function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

fsx_variable_subscribe("TURB ENG CORRECTED FF:1", "Pounds per hour",
                       "TURB ENG CORRECTED FF:2", "Pounds per hour",
					   "TURB ENG CORRECTED FF:3", "Pounds per hour",
                       "TURB ENG CORRECTED FF:4", "Pounds per hour",
 PT_fuel_flow_FSX)

 fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)