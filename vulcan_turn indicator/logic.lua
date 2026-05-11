--- vulcan turn ---

img_add_fullscreen("turn back day.png")
--img_night = img_add("turn back.png", 0,0,400,400)
img_plane = img_add("turn indicator.png",0,0,400,400)
img_vee = img_add("turn vee.png",0,0,400,400)
img_horizon = img_add("horizon.png",0,0,400,400)

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

function PT_atitude(roll, pitch)    
-- roll outer ring
    img_rotate(img_plane, roll *-1)
        
-- roll horizon
    img_rotate(img_horizon  , roll * -1)
    
-- move horizon pitch
    pitch = var_cap(pitch,-30,30)
    radial = math.rad(roll * -1)
    x = -(math.sin(radial) * pitch * 3)
    y = (math.cos(radial) * pitch * 3)
    img_move(img_horizon, x, y, nil, nil)
 
end

function new_attitude_fsx(roll, pitch, slip)
	
	PT_atitude(roll *-1, pitch * -1)
	
end	


fsx_variable_subscribe("ATTITUDE INDICATOR BANK DEGREES", "Degrees",
					   "ATTITUDE INDICATOR PITCH DEGREES", "Degrees", new_attitude_fsx)
					   
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/roll_vacuum_deg_pilot", "FLOAT",
                            "sim/cockpit2/gauges/indicators/pitch_vacuum_deg_pilot", "FLOAT", new_attitude_fsx )

-- This is where we check if the backlight (cockpit light) is on, currently disabled, re-enable when req, and set up for x-plane --

-- fsx_variable_subscribe("LIGHT PANEL", "bool",
--				   light_fsx)