--- vulcan control surfaces ---

img_add_fullscreen("control_back.png")
img_add_fullscreen("control_stensil.png")
img_night_back = img_add("control back night.png" , 0,0,512,168)
img_night = img_add("controlback stensil night.png", 0,0,512,168)

left_a = img_add("control line.png", 35,101,51,6)
left_s = img_add("control line.png", 164,101,51,6)
right_a = img_add("control line.png", 426,101,51,6)
right_s = img_add("control line.png", 296,101,51,6)
rudder_c = img_add("control line rudder.png", 247,9,4,41)


function rudder_controls_pct(rudder)

      rudder = var_cap(rudder,-63,63)
      x = rudder / 2
	
	  img_move(rudder_c, x + 254, nil, nil, nil)

end

function elevator_controls_left_pct(elevator, aileron)

      elevator = var_cap(elevator,-50,50)
	  aileron = var_cap(aileron,-50,50)

      x = -elevator / 2.5
	  y = -aileron / 2
	  z = x - y
	  
	  img_move(left_a, nil, z + 101, nil, nil)
	  img_move(left_s, nil, z + 101, nil, nil)
	
end

function elevator_controls_right_pct(elevator, aileron)

      elevator = var_cap(elevator,-50,50)
	  aileron = var_cap(aileron,-50,50)

      x = -elevator / 2.5
	  y = aileron / 2
	  z = x - y
	  
	  img_move(right_a, nil, z + 101, nil, nil)
	  img_move(right_s, nil, z + 101, nil, nil)

end

function rudder_pct(rudder_flt)
    rudder_controls_pct((rudder_flt / 35 * 100))
end
function left_pct(elevator_flt, aileronL_flt)
    elevator_controls_left_pct((elevator_flt / 16 * 100),(aileronL_flt / -16 * 100))
end          
function right_pct(elevator_flt, aileronR_flt)
    elevator_controls_right_pct((elevator_flt / 16 * 100),(aileronR_flt / -16 * 100))
end 
xpl_dataref_subscribe("thranda/anim/rudder", "FLOAT", rudder_pct)
xpl_dataref_subscribe("thranda/anim/elevator", "FLOAT", "thranda/anim/aileronL", "FLOAT", left_pct)
xpl_dataref_subscribe("thranda/anim/elevator", "FLOAT", "thranda/anim/aileronR", "FLOAT", right_pct)
 
 