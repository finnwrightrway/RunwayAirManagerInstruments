--       vulcan hyd      --
--     Load and display images     --
-------------------------------------

img_add_fullscreen("hyd back.png")
--img_night = img_add("hyd back night.png", 0,0,200,200)
hand_1 = img_add("hyd needle pressure.png", 85,0,12,80)
hand_2 = img_add("hyd needle pressure.png", 85,120,12,80)
hand_3 = img_add("hyd needle cap.png", 27,94,125,12)
-- Functions --

--print(string)

function new_hyd_FSX(hydp1, hydp2, hydres)
             img_rotate(hand_1, (160 / 5000 * hydp1) -120)
			 img_rotate(hand_2, (160 / 5000 * -hydp2) -62)
	         img_rotate(hand_3, (hydres /1.4 ) -48)
end

function xpl_data(sys1, sys2, fluid1, fluid2)
            fluid = (fluid1 + fluid2) / 2
            fluid100 = fluid * 100
            new_hyd_FSX( sys1, sys2, fluid100)
end


-------------------
-- Bus subscribe --
-------------------

fsx_variable_subscribe("HYDRAULIC PRESSURE:1", "Psi", 
                       "HYDRAULIC PRESSURE:2", "Psi",
                       "HYDRAULIC RESERVOIR PERCENT:1", "Percent", 
new_hyd_FSX)

xpl_dataref_subscribe("sim/cockpit2/hydraulics/indicators/hydraulic_pressure_1", "FLOAT",
                        "sim/cockpit2/hydraulics/indicators/hydraulic_pressure_1", "FLOAT",
                            "sim/cockpit2/hydraulics/indicators/hydraulic_fluid_ratio_1", "FLOAT", 
                                "sim/cockpit2/hydraulics/indicators/hydraulic_fluid_ratio_2", "FLOAT",
                                    xpl_data)

	