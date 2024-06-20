--- vulcan beam compass ---

-- ADD IMAGES --


img_add_fullscreen("beam_compass_back.png")
img_night = img_add("beam_compass_back_night.png", 0,0,400,400)
img_fr = img_add("OBS2navfr.png", 0,0,400,400)
img_to = img_add_fullscreen("OBS2navto.png")
img_navflag = img_add("OBS2navflag.png", 0,0,400,400)
img_beam = img_add("hor bar.png",0,0,400,400)
img_card = img_add("rose back.png", 0,0,400,400)
img_night_rose = img_add("rose back night.png", 0,0,400,400)
img_night_glow = img_add("rose back glow.png", 0,0,400,400)
img_heading_pointer = img_add_fullscreen("beam needle.png")
img_bug = img_add_fullscreen("bug.png")
img_dgflag = img_add("dg flag.png", 0,0,400,400)

			  
	-- DEFAULT VISIBILITY --
visible(img_to, false)
visible(img_fr, false)
visible(img_navflag, false)	
visible(img_dgflag, true)	  
			  
-- Callback functions (handles data received from X-plane or FSX)

function new_info_fsx(nav2sig, tofromnav)
	
	visible(img_navflag, tofromnav == 0)
	visible(img_to, tofromnav == 1)
	visible(img_fr, tofromnav == 2)
	visible(img_dgflag, nav2sig == 0)
	
end

function new_headbug( bug)

	img_rotate(img_bug,bug )

end

function new_combined(degm)

	img_rotate(img_heading_pointer, degm )

end

function new_knob_hdg(value)

	if value == 1 then
		fsx_event("HEADING_BUG_INC")

	elseif value == -1 then
		fsx_event("HEADING_BUG_DEC")

	end

end

function new_obs(obs)

	if obs == -1 then
		xpl_command("sim/radios/obs2_up")
		fsx_event("VOR2_OBI_INC")
	elseif obs == 1 then
		xpl_command("sim/radios/obs2_down")
		fsx_event("VOR2_OBI_DEC")
	end

end

function new_obsheading(obs)
-- Rotate the omni bearing selector
	img_rotate(img_card, (obs * -1))
	img_rotate(img_night_rose, (obs * -1))

end

function new_dots_fsx(horizontal)

	-- Localizer
	horizontal =  horizontal * .7
	horizontal = var_cap(horizontal, -80, 80)
	img_move(img_beam, horizontal, nil, nil, nil )
	
end


function light_fsx(lightpanel)

      visible(img_night, lightpanel)	
	   visible(img_night_rose, lightpanel)
	  visible(img_night_glow, lightpanel)
	  
end

-- Data bus subscribe --



fsx_variable_subscribe("AUTOPILOT HEADING LOCK DIR", "degrees", 
					   new_headbug)
					   
fsx_variable_subscribe("PLANE HEADING DEGREES GYRO", "degrees",
					   new_combined)					   
						
fsx_variable_subscribe("NAV OBS:1", "Degrees",
                      "AUTOPILOT HEADING LOCK DIR", "degrees", 
                       new_obsheading)

fsx_variable_subscribe("NAV CDI:1", "Number", new_dots_fsx)		

fsx_variable_subscribe("LIGHT PANEL", "bool",
                       "PLANE HEADING DEGREES GYRO", "degrees", 
					   light_fsx)		
					   
fsx_variable_subscribe("NAV HAS NAV:1", "Bool",
					   "NAV TOFROM:1", "Enum", 
					   new_info_fsx)
					   					   