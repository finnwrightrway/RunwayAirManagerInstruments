--- vulcan control surfaces ---

--DO NOT USE--

img_add_fullscreen("control_back.png")
img_add_fullscreen("control_stensil.png")
--img_night_back = img_add("control back night.png" , 0,0,512,168)
--img_night = img_add("controlback stensil night.png", 0,0,512,168)

left_a = img_add("control line.png", 35,101,51,6)
left_s = img_add("control line.png", 164,101,51,6)
right_a = img_add("control line.png", 426,101,51,6)
right_s = img_add("control line.png", 296,101,51,6)
rudder_c = img_add("control line rudder.png", 247,9,4,41)


function PT_rudder_controls(rudder_ratio)
      rudder = (rudder_ratio * 100)
      rudder = var_cap(rudder,-63,63)
      x = rudder / 2
	
	  img_move(rudder_c, x + 254, nil, nil, nil)

end

function PT_elevator_controls_left(elevator_ratio, aileron_ratio)

      elevator = (elevator_ratio * 100)
      aileron = (aileron_ratio * 100)

      elevator = var_cap(elevator,-50,50)
	  aileron = var_cap(aileron,-50,50)

      x = -elevator / 2.5
	  y = -aileron / 2
	  z = x - y
	  
	  img_move(left_a, nil, z + 101, nil, nil)
	  img_move(left_s, nil, z + 101, nil, nil)
	
end

function PT_elevator_controls_right_FSX(elevator, aileron)

      elevator = var_cap(elevator,-50,50)
	  aileron = var_cap(aileron,-50,50)

      x = -elevator / 2.5
	  y = aileron / 2
	  z = x - y
	  
	  img_move(right_a, nil, z + 101, nil, nil)
	  img_move(right_s, nil, z + 101, nil, nil)

end


function light_fsx(lightpanel )
      visible(img_night_back, lightpanel)
      visible(img_night, lightpanel)
end
xpl_dataref_subscribe("sim/aircraft/controls/acf_rudd_tab", "FLOAT", PT_rudder_controls)

 
 xpl_dataref_subscribe("sim/aircraft/controls/acf_elev_tab", "FLOAT",
                          "AILERON LEFT DEFLECTION PCT", "Percent",
 PT_elevator_controls_left)
 
   fsx_variable_subscribe("sim/aircraft/controls/acf_elev_tab", "FLOAT",
                          "AILERON RIGHT DEFLECTION PCT", "Percent",
 PT_elevator_controls_right_FSX)
 