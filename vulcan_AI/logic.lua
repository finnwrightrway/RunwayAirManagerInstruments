-- vulcan AI ----

img_add_fullscreen("ai_back.png")
img_night = img_add("ai back night.png", 0,0,400,400)
img_ils_r_bar = img_add("ils_roll.png",42,80,318,318)
img_ils_p_bar = img_add("ils_pitch.png",142,0,117,4)
img_roll_bar = img_add("roll bar.png",42,80,318,318)
img_pitch_bar = img_add("pitch bar.png",42,95,318,318)
img_gs_tab_bar = img_add("gs_tab.png",231,40,17,37)
img_beam = img_add("beam.png",156,40,17,37)
img_pitch = img_add("p_tab.png",273,56,46,22)
img_strips = img_add("strips_tab.png",57,75,76,51)
img_strips_off = img_add("strips_off_tab.png",56,74,78,53)


	-- DEFAULT VISIBILITY --
visible(img_strips_off, true)
visible(img_strips, true)
visible(img_gs_tab_bar, false)
visible(img_beam, false)
visible(img_pitch, true)

-- Functions --
function PT_atitude(roll, pitch)    

-- roll horizon
    img_rotate(img_roll_bar  , roll * -1)
	
-- move horizon pitch
    pitch = var_cap(pitch,-14,30)
    radial = math.rad(roll * -1)
    y = (math.cos(radial) * -pitch * 3.3)
    img_move(img_pitch_bar, nil, y + 95, nil, nil)
 
end

function new_attitude_fsx(roll, pitch, slip)
	
	PT_atitude(roll *-1, pitch * -1)

end

function new_dots_fsx(vertical, horizontal)

	-- Move the CDI bar	
	vertical = var_cap(vertical, -90, 90)
	img_rotate(img_ils_r_bar, (-vertical + 3) * .3)

-- Move the glideslope indicator
    horizontal = var_cap(horizontal, -150, 90)
	move(img_ils_p_bar, nil, (horizontal) + 264, nil, nil)	
end

function new_info_fsx(glideslopeflag, avionics, lightpanel, localizer )

	glideslopeflag = fif(glideslopeflag, 1, 0)
    visible(img_gs_tab_bar, glideslopeflag == 1)
	 visible(img_night, lightpanel)
	      visible(img_strips_off, avionics)
	 visible(img_beam, localizer)
	  visible(img_pitch, glideslopeflag == 0)
end

fsx_variable_subscribe("ATTITUDE INDICATOR BANK DEGREES", "Degrees",
					   "ATTITUDE INDICATOR PITCH DEGREES", "Degrees", new_attitude_fsx)
					   
fsx_variable_subscribe("NAV CDI:1", "Number",
					   "NAV GSI:1", "Number",
					   new_dots_fsx)		

fsx_variable_subscribe("NAV GS FLAG:1", "Bool", 
					   "CIRCUIT AVIONICS ON", "Bool",
					   "LIGHT PANEL", "bool",
					   "NAV HAS LOCALIZER:1", "Bool",
					   new_info_fsx)		   