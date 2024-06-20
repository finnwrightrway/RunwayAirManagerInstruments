----- vulcan autopilot ------

img_add_fullscreen("autopilot back.png")
img_on = img_add_fullscreen("ap_on.png")
img_hdg = img_add_fullscreen("ap_hdg.png")
img_speed = img_add_fullscreen("ap_speed.png")
img_alt = img_add_fullscreen("ap_alt.png")
img_nav = img_add_fullscreen("ap_nav.png")
img_app = img_add_fullscreen("ap_app.png")
img_gs = img_add_fullscreen("ap_gs.png")
img_blank = img_add_fullscreen("ap_blank.png")

	-- DEFAULT VISIBILITY --
visible(img_on, true)
visible(img_hdg, true)
visible(img_speed, true)	
visible(img_alt, true)	  
visible(img_nav, true)
visible(img_app, true)	
visible(img_gs, true)	 

    ---- FUNCTIONS--------

function AP_fsx(ap, hdg, speed, alt, nav, apr, gs)
	
	visible(img_on, ap)
	visible(img_hdg, hdg)
	visible(img_speed, speed)
	visible(img_alt, alt)
	visible(img_nav, nav)
	visible(img_app, apr)
	visible(img_gs, gs)
	
end

fsx_variable_subscribe("AUTOPILOT MASTER", "Bool",
                       "AUTOPILOT HEADING LOCK", "Bool",
					   "AUTOPILOT AIRSPEED HOLD", "Bool",
					   "AUTOPILOT ALTITUDE LOCK", "Bool",
					   "AUTOPILOT NAV1 LOCK", "Bool",
					   "AUTOPILOT APPROACH HOLD", "Bool",
					   "AUTOPILOT GLIDESLOPE HOLD", "Bool",
					   AP_fsx)
					   					   