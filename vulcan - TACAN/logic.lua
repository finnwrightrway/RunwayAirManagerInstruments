-- vulcan adf --
ten = img_add_fullscreen("tac_d_l.png") --position not set
one = img_add_fullscreen("tac_d_r.png") --position not set

img_add_fullscreen("tac_back.png")

--img_night = img_add("adf back night.png", 0,0,400,400)

needle = img_add_fullscreen("tac_needle.png")

off = img_add_fullscreen("tac_off.png")

--default visibility-
visible(off, false)

function radial(vor_radial, dme_on)

		img_rotate(needle, vor_radial)
		
	
end

function dist(dme)
    img_rotate(one, (dme * -36))
    img_rotate(ten, (dme * 3.6))


end

visible(off, dme_on < 1)

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end




fsx_variable_subscribe("NAV RADIAL:1", "Degrees",
                        "NAV HAS DME:1" "number" 
                       radial)

fsx_variable_subscribe("NAV DME:1", "nautical miles",
                       dist)	

fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	   