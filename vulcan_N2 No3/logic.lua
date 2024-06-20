--    Vulcan N2 No3       --
-------------------------------------
--     Load and display images     --
-------------------------------------

img_add_fullscreen("n1 back.png")
img_night = img_add("n1 back night.png", 0,0,200,200)
N1_hand = img_add("N1 hand.png", 0, 0, 200, 200)
ltl_hand = img_add("little hand.png", 39,29,50,50)
posn_no = 1
---------------
-- Functions --
---------------

function move_needle(lim_lo, lim_hi, deg_offs, deg_travel, c_travel, c_reading, TEST)
knots_offset = lim_lo
	if c_reading[posn_no] >= lim_lo and c_reading[posn_no] < lim_hi then
		c_reading[posn_no] = var_cap(c_reading[posn_no], lim_lo, lim_hi)
		img_rotate(N1_hand, deg_offs+(deg_travel*(c_reading[posn_no]-lim_lo)/c_travel))
		img_rotate(ltl_hand, 127+deg_offs+(360*(c_reading[posn_no]/c_travel)*11))
	
	end	
end

function N1_posn(c_reading,power)

--lim_lo, lim_hi, deg_offs, deg_travel, c_travel, c_reading, TEST	
move_needle(0,103,0,272,100.1,c_reading, "0-300 deg_c ")	



end

function N1_posn_FSX(N1_2)

	N1_posn({N1_2})
	
end

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

-------------------
-- Bus subscribe --
-------------------

xpl_dataref_subscribe("sim/flightmodel/engine/ENGN_N1_", "FLOAT[8]", N1_posn)
fsx_variable_subscribe("TURB ENG CORRECTED N1:3", "Percent", N1_posn_FSX)

fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	