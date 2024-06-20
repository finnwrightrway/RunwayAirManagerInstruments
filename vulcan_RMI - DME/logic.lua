------------------------------------

--- Vulcan -------
--RMI with DME -------
------------------------------------
-- Persistence for source selection
per_s1 = persist_add("source1", "INT", 0)
per_s2 = persist_add("source2", "INT", 0)

-- Global variables --
-- Initialize the needles at 90 degrees
local gbl_cur_s1_heading    = 90
local gbl_target_s1_heading = 0
local gbl_cur_s2_heading    = 90
local gbl_target_s2_heading = 0
local gbl_factor            = 0.26
local gbl_left_rmi  		= persist_get(per_s1)
local gbl_right_rmi 		= persist_get(per_s2)

-- Add images and text --
img_add_fullscreen("background.png")
img_night = img_add("background night.png", 0,0,500,500)

txt_dme1 = txt_add("888", "-fx-font-size:70px; -fx-fill: #ffffff; -fx-font-weight:bold; -fx-text-alignment:right;", 135, 130, 150, 72)
--img_add("window.png", 91, 37, 300, 72)

--img_compass = img_add("compass.png", 70, 166, 340, 340)
img_s2_needle = img_add("green_arrow.png", 220, 106, 60, 290)
--img_add("bottom_cap.png", 214, 310, 52, 52)
img_s1_needle = img_add("yellow_arrow.png", 230, 106, 40, 290)
--img_add("top_cap.png", 214, 310, 52, 52)
--img_add("lubberline.png", 215, 146, 50, 40)

img_y_vor = img_add("y_vor.png", 150, 298, 38, 38)
img_g_vor = img_add("g_vor.png", 316, 298, 38, 38)

-- Button callbacks --
function callback_b1()

	xpl_command("sim/radios/RMI_L_tog")

	-- No RMI source select in FSX/P3D, so we have to fake this	
	gbl_left_rmi = fif(gbl_left_rmi == 0, 1, 0)
	persist_put(per_s1, gbl_left_rmi)

end

function callback_b2()

	xpl_command("sim/radios/RMI_R_tog")
	
	-- No RMI source select in FSX/P3D, so we have to fake this
	gbl_right_rmi = fif(gbl_right_rmi == 0, 1, 0)
	persist_put(per_s2, gbl_right_rmi)

end

-- Functions --
function new_data_xpl(degm, relbnav1, relbnav2, relbadf1, relbadf2, avionics_on, adf1_power, nav1_power, nav2_power, left_rmi, right_rmi,
				      nav1_has_dme, nav2_has_dme, adf1_has_dme, adf2_has_dme, nav1_distance, nav2_distance, adf1_distance, adf2_distance)

	-- Should the distance text be visible?
	visible(txt_dme1, avionics_on == 1 and ((left_rmi == 0 and nav1_has_dme == 1) or (left_rmi == 1 and adf1_has_dme)) )
	visible(txt_dme2, avionics_on == 1 and ((right_rmi == 0 and nav2_has_dme == 1) or (right_rmi == 1 and adf2_has_dme)) )
	
	-- Set the DME distance text elements
	if left_rmi == 0 then
		txt_set(txt_dme1, var_round(nav1_distance, 0))
	elseif left_rmi == 1 then
		txt_set(txt_dme1, var_round(adf1_distance, 0))
	end

	if right_rmi == 0 then
		txt_set(txt_dme2, var_round(nav2_distance, 0))
	elseif left_right == 1 then
		txt_set(txt_dme2, var_round(adf2_distance, 0))
	end
	
	-- Is the yellow needle showing ADF or VOR, is the green needle showing ADF or VOR?
	visible(img_y_adf, left_rmi == 1)
	visible(img_g_adf, right_rmi == 1)
	visible(img_y_vor, left_rmi == 0)
	visible(img_g_vor, right_rmi == 0)
	
	-- Rotate the compass rose
--	img_rotate(img_compass, degm * -1)
	
	-- Rotate source 1 needle (yellow)

	if avionics_on == 1 and left_rmi == 0 and nav1_power > 0 then
		gbl_target_s1_heading = relbnav1
	elseif avionics_on == 1 and left_rmi == 1 and adf1_power > 0 then
		gbl_target_s1_heading = relbadf1
	else
		gbl_target_s1_heading = 90
	end

	-- Rotate source 2 needle (green)
	if avionics_on == 1 and right_rmi == 0 and nav2_power > 0 then
		gbl_target_s2_heading = relbnav2
	elseif avionics_on == 1 and right_rmi == 1 and adf1_power > 0 then
		gbl_target_s2_heading = relbadf2
	else
		gbl_target_s2_heading = 90
	end
end

-- Slowly move needle to current heading --
function timer_callback()	

    -- Rotate needle images
	img_rotate(img_s1_needle, gbl_cur_s1_heading)
    img_rotate(img_s2_needle, gbl_cur_s2_heading)

    -- Source 1 needle
    raw_diff = (360 + gbl_target_s1_heading - gbl_cur_s1_heading) %360
    diff = fif(raw_diff < 180, raw_diff, (360 - raw_diff) * -1)
    gbl_cur_s1_heading = fif(math.abs(diff) < 0.001, gbl_target_s1_heading, gbl_cur_s1_heading + (diff * gbl_factor) )

    -- Source 2 needle
    raw_diff = (360 + gbl_target_s2_heading - gbl_cur_s2_heading) %360
    diff = fif(raw_diff < 180, raw_diff, (360 - raw_diff) * -1)
    gbl_cur_s2_heading = fif(math.abs(diff) < 0.001, gbl_target_s2_heading, gbl_cur_s2_heading + (diff * gbl_factor) )

end

function new_data_fsx(degm, relbnav1, relbnav2, relbadf1, relbadf2, avionics_on, nav1_has_dme, nav2_has_dme, adf1_has_dme, 
					  adf2_has_dme, nav1_distance, nav2_distance, adf1_distance, adf2_distance)

    -- Convert booleans to integers					  
	avionics_on = fif(avionics_on, 1, 0)
	nav1_has_dme = fif(nav1_has_dme, 1, 0)
	nav2_has_dme = fif(nav2_has_dme, 1, 0)
	adf1_has_dme = fif(adf1_has_dme, 1, 0)
	adf2_has_dme = fif(adf2_has_dme, 1, 0)

	-- Send FSX data to the X-Plane code
	new_data_xpl(degm, relbnav1, relbnav2, relbadf1, relbadf2, avionics_on, 1, 1, 1, gbl_left_rmi, gbl_right_rmi, nav1_has_dme, nav2_has_dme, adf1_has_dme, adf2_has_dme, nav1_distance, nav2_distance, adf1_distance, adf2_distance)					  

end					  

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

-- Data subscribe --

fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	

fsx_variable_subscribe("PLANE HEADING DEGREES GYRO", "DEGREES", 
					   "NAV RELATIVE BEARING TO STATION:1", "DEGREES", 
					   "NAV RELATIVE BEARING TO STATION:2", "DEGREES", 
					   "ADF RADIAL:1", "DEGREES", 
					   "ADF RADIAL:2", "DEGREES", 
					   "AVIONICS MASTER SWITCH", "BOOLEAN", 
					   "NAV HAS DME:1", "BOOLEAN", 
					   "NAV HAS DME:2", "BOOLEAN",
					   "NAV HAS DME:3", "BOOLEAN", 
					   "NAV HAS DME:4", "BOOLEAN",
					   "NAV DME:1", "NAUTICAL MILES", 
					   "NAV DME:2", "NAUTICAL MILES", 
					   "NAV DME:3", "NAUTICAL MILES",
					   "NAV DME:4", "NAUTICAL MILES", new_data_fsx)					  
					  
-- Timers --
tmr_update = timer_start(0, 50, timer_callback)					  