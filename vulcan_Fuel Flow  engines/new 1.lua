--- vulcan fuel flow engines ----

img_add_fullscreen("fuel flow eng.png")
img_night = img_add("fuel flow eng night.png", 0,0,250,250)
img_outer_4 = img_add("needle eng4.png",0,0,250,250)
img_outer_3 = img_add("needle eng3.png",0,0,250,250)
img_outer_2 = img_add("needle eng2.png",0,0,250,250)
img_outer_1 = img_add("needle eng1.png",0,0,250,250)

print(fuelf)

function PT_fuel_flow_1(fuelflow)

     angle = (fuelflow[1] /30)
	   img_rotate(img_outer_1, angle + 149)
  end

function PT_fuel_flow_2(fuelflow)

      angle = (fuelflow[1] /30)
	   img_rotate(img_outer_2, angle + 149)
	
end

function PT_fuel_flow_3(fuelflow)

      angle = (fuelflow[1] /30)
	   img_rotate(img_outer_3, angle + 148) 
	
end

function PT_fuel_flow_4(fuelflow)

      angle = (fuelflow[1] /30)
	   img_rotate(img_outer_4, angle + 148)
end


function PT_fuel_flow_FSX(fuelflow_1, fuelflow_2, fuelflow_3, fuelflow_4)
	
	PT_fuel_flow_1( {fuelflow_1} )
    PT_fuel_flow_2( {fuelflow_2} )
	PT_fuel_flow_3( {fuelflow_3} )
	PT_fuel_flow_4( {fuelflow_4} )
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