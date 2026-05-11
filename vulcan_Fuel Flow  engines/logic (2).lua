--- vulcan fuel flow engines ----

img_add_fullscreen("fuel flow eng.png")
img_night = img_add("fuel flow eng night.png", 0,0,250,250)
img_needle = img_add("needle outer.png",0,0,250,250)

print(fuelf)

function PT_fuel_flow_FSX(fuelflow_1, fuelflow_2, fuelflow_3, fuelflow_4)

     angle1 = (fuelflow_1 )
	  angle2 = (fuelflow_2 )
	  angle3 = (fuelflow_3 )
	  angle4 = (fuelflow_4 )
	  
	  angletotal = (angle1+angle2+angle3+angle4)
	  
	  if angletotal <=101 then
	   img_rotate(img_needle, angletotal * 2.58)
	   else 
	   img_rotate(img_needle, ((angletotal * 0.26) +229))
	   end
	   
	    angletotalcap = var_cap(angletotal,0,400)
  end

--function PT_fuel_flow_FSX(fuelflow_1)
	
	--PT_fuel_flow_1( {fuelflow_1} )
    --PT_fuel_flow_2( fuelflow )
--end

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