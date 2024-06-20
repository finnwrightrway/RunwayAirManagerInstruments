--- vulcan fuel flow ----

img_add_fullscreen("fuel flow back.png")
img_night = img_add("fuel flow back night.png", 0,0,400,400)
img_outer = img_add("needle outer.png",0,0,400,400)
img_inner = img_add("needle inner.png",0,0,400,400)
img_used = img_add("needle used.png",0,0,400,400)

print(string)

function PT_fuel_flow(fuelflow)

	angle = (fuelflow[1] * 0.54)
    img_rotate(img_outer, ((angle / 10) -54 ))
	img_rotate(img_inner, ((angle / 100) -79) )
end

function PT_fuel_flow_FSX(fuelflow_1, fuelflow_2, fuelflow_3, fuelflow_4)
	
	eng1 = (fuelflow_1)
	eng2 = (fuelflow_2)
	eng3 = (fuelflow_3)
	eng4 = (fuelflow_4)
	PT_fuel_flow( {eng1 + eng2 + eng3 + eng4} )

end

function PT_fuel_used_FSX(fuelused)

	used = (fuelused)
    img_rotate(img_used, (used / 10) )
	
end

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

fsx_variable_subscribe("TURB ENG CORRECTED FF:1", "Pounds per hour",
                       "TURB ENG CORRECTED FF:2", "Pounds per hour",
                       "TURB ENG CORRECTED FF:3", "Pounds per hour",
                       "TURB ENG CORRECTED FF:4", "Pounds per hour",
 PT_fuel_flow_FSX)
 
 fsx_variable_subscribe("GENERAL ENG FUEL USED SINCE START","pounds",
 PT_fuel_used_FSX)
                         


fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	
					   
---GENERAL ENG FUEL USED SINCE START--
--TURB ENG FUEL FLOW PPH:index--