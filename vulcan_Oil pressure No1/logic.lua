--       vulcan Eng Oil Px No1      --
-------------------------------------
--     Load and display images     --
-------------------------------------

img_add_fullscreen("oil back.png")
img_night = img_add("oil back night.png", 0,0,200,200)
hand = img_add("oil hand.png", 0,0,200,200)

-- Functions --

function new_oil(oilp)

	oilp = var_cap(oilp[1], 0, 100)

	if oilp >= 80 then
		img_rotate(hand, 65/ 20 * (oilp -80) +80)
	elseif oilp >= 60 then
		img_rotate(hand, 48/ 20 * (oilp -60) +32)
	elseif oilp >= 40 then
		img_rotate(hand, 68 / 21 * (oilp -40) -31)
	elseif oilp >= 20 then
		img_rotate(hand, 48 / 20 * (oilp -20) -78)
	elseif oilp <= 19 then
		img_rotate(hand, 65 / 20 * (oilp) -143)
	end


end


function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

function new_oil_FSX(oilp)

	new_oil({oilp})
	
end

-------------------
-- Bus subscribe --
-------------------
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/oil_pressure_psi", "FLOAT[8]", new_oil)
fsx_variable_subscribe("ENG OIL PRESSURE:1", "Psi", new_oil_FSX)

fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	
