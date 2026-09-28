--- vulcan fuel flow ----

img_add_fullscreen("fuel flow back.png")
img_night = img_add("fuel flow back night.png", 0,0,400,400)
img_inner = img_add("needle inner.png",0,0,400,400)
img_outer = img_add("needle outer.png",0,0,400,400)

txt_used = txt_add ("000000", "size:52; font:London-Tube.ttf; color: #b5b5b5; halign:center; valign:top", 124, 287, 154, 94)
---------------------------------------------------------------


--fuel used digits

function PT_fuel_counter_fsx (gallons_left,gallons_right,gallons_center,gallons_center2) 

     left_tank = (3200 - gallons_left)  
	 right_tank = (3200 - gallons_right)  
	 center_tank = (3133.5 - gallons_center)  
	 center2_tank = (3133.5 - gallons_center2)  
  
	 used = (left_tank + right_tank + center_tank + center2_tank)
	 used_text = var_round(used * 3.03954, 0)
	txt_set(txt_used, used_text)

end

function fuel_used_xpl(used)

        used_lb = used * 2.2
        used_lb_rnd = var_format(used_lb,0)
        text = string.format("%06d", used_lb_rnd)
        txt_set(txt_used, text)

end

----------------------------------------------------------
	
-- fuel flow calculation
function PT_fuel_flow(fuelflow)

	angle = (fuelflow[1] * 0.36)
    img_rotate(img_outer, (angle / 10 ))
	img_rotate(img_inner, (angle / 100 ))
end

--fuel flow needles
function PT_fuel_flow_FSX(fuelflow_1, fuelflow_2, fuelflow_3, fuelflow_4)
	
	eng1 = (fuelflow_1)
	eng2 = (fuelflow_2)
	eng3 = (fuelflow_3)
	eng4 = (fuelflow_4)
	PT_fuel_flow( {eng1 + eng2 + eng3 + eng4} )

end	

function xpl_conv(ff_xp) --reqired to expand the float and convery kg/s to lb/hr

        ff_1 = ff_xp[1] * 2.2 * 60
        ff_2 = ff_xp[2] * 2.2 * 60
        ff_3 = ff_xp[3] * 2.2 * 60
        ff_4 = ff_xp[4] * 2.2 * 60
        
        PT_fuel_flow_FSX(ff_1, ff_2, ff_3, ff_4)
end



function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

fsx_variable_subscribe("TURB ENG CORRECTED FF:1", "Pounds per hour",
                       "TURB ENG CORRECTED FF:2", "Pounds per hour",
                       "TURB ENG CORRECTED FF:3", "Pounds per hour",
                       "TURB ENG CORRECTED FF:4", "Pounds per hour",
 PT_fuel_flow_FSX)

xpl_dataref_subscribe("{sim/cockpit2/engine/indicators/fuel_flow_kg_sec", "FLOAT[4]", xpl_conv)
  
                       
fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	
					   
fsx_variable_subscribe("FUEL LEFT QUANTITY", "Gallons",
                       "FUEL RIGHT QUANTITY", "Gallons",
					   "FUEL TANK CENTER QUANTITY", "Gallons",
					   "FUEL TANK CENTER2 QUANTITY", "Gallons",
					   PT_fuel_counter_fsx)
					   
					   					   					   
xpl_dataref_subscribe("sim/cockpit2/fuel/fuel_totalizer_sum_kg", "FLOAT", fuel_used_xpl)
					   					   
--"GENERAL ENG FUEL USED SINCE START", "pounds",					   
--TURB ENG FUEL FLOW PPH:index--

 -- Convert weight in KG to gallons with 6.006 lbs / gallon

--