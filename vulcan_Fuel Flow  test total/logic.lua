--- vulcan fuel flow ----

img_add_fullscreen("fuel_flow_back.png")
img_outer = img_add("needle outer.png",0,0,400,400)
img_inner = img_add("needle inner.png",0,0,400,400)

print(string)

function PT_fuel_flow(fuelflow)

	angle = (fuelflow[1] * 3.6 )
    img_rotate(img_outer, angle )
	img_rotate(img_inner, angle / 100)
end

function PT_fuel_flow_FSX(fuelflow_1, fuelflow_2, fuelflow_3, fuelflow_4)
	
	eng1 = (fuelflow_1)
	eng2 = (fuelflow_2)
	eng3 = (fuelflow_3)
	eng4 = (fuelflow_4)
	PT_fuel_flow( {eng1 + eng2 + eng3 + eng4} )

end


fsx_variable_subscribe("TURB ENG FUEL FLOW:1", "Pounds per hour",
                       "TURB ENG FUEL FLOW:2", "Pounds per hour",
                       "TURB ENG FUEL FLOW:3", "Pounds per hour",
                       "TURB ENG FUEL FLOW:4", "Pounds per hour",
 PT_fuel_flow_FSX)


---GENERAL ENG FUEL USED SINCE START--
--TURB ENG FUEL FLOW PPH:index--