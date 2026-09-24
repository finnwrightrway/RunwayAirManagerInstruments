--       Vulcan EGT  No2     --
-------------------------------------
--     Load and display images     --
-------------------------------------
img_add_fullscreen("EGT back.png")
img_night = img_add("EGT back night.png", 0,0,200,200)
EGT_hand = img_add("EGT hand.png", 0, 0, 200, 200)
ENG=2
---------------
-- Functions --
---------------

function new_tot(tot)
	
	tot1 = var_cap(tot[1], 0, 800)
	img_rotate(EGT_hand, (300 / 1000 * tot1) -94)
	
end

function Function_xpl(egt)
        egt3=egt[ENG] * 2 --possibly JF Vulcan Quirk
	Function_FSX(egt3)

end

function Function_FSX(tot)

	new_tot({tot})

end

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

-------------------
-- Bus subscribe --
-------------------
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/EGT_deg_cel", "FLOAT[16]", Function_xpl)
fsx_variable_subscribe("ENG EXHAUST GAS TEMPERATURE:3", "Celsius", Function_FSX)
fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)