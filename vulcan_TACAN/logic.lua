-- vulcan adf --

ten = img_add("tac_d_l.png",-5,52,200,200)
one = img_add("tac_d_r.png",193,52,200,200)
img_add_fullscreen("tac_back.png")




--img_night = img_add("adf back night.png", 0,0,400,400)

needle = img_add("tac_needle.png",182,46,45,325)

off = img_add_fullscreen("tac_off.png")

--default visibility-


function radial(vor_radial, dme_on, head)

		img_rotate(needle, (vor_radial - 180 - head))
		visible(off, dme_on == false)
		
	
end

function dist(dme)
    dme10 = (dme * 0.1)
    dmenew = math.floor(dme10)
    
    img_rotate(one, (dme * 36))
    img_rotate(ten, (dmenew * -36))


end

--visible(off, dme_on < 1)

function light_fsx(lightpanel )

      --visible(img_night, lightpanel)	
end




fsx_variable_subscribe("NAV RADIAL:1", "Degrees",
                        "NAV HAS DME:1", "bool",
                        "PLANE HEADING DEGREES MAGNETIC", "Degrees", 
                       radial)
                       
xpl_dataref_subscribe("sim/cockpit/radios/nav1_course_degm", "FLOAT", 
                        "sim/cockpit/radios/nav1_has_dme", "FLOAT",
                            "sim/cockpit2/gauges/indicators/heading_vacuum_deg_mag_pilot", "FLOAT", radial)
                            
xpl_dataref_subscribe("sim/cockpit/radios/nav1_dme_dist_m", "FLOAT", dist)
fsx_variable_subscribe("NAV DME:1", "nautical miles",
                       dist)	

-- This is where we check if the backlight (cockpit light) is on, currently disabled, re-enable when req, and set up for x-plane --

-- fsx_variable_subscribe("LIGHT PANEL", "bool",
--				   light_fsx) 