--- vulcan slip ---
img_add_fullscreen("slip back.png")
img_night = img_add("slip back night.png", 0,0,300,75)
img_ball = img_add("ball.png", 128,28,44,44)

function new_ball_deflection(slip)
	slip = var_cap(slip, -8.1, 8.1)

	slip_rad = math.rad(slip * 1.6)
	x = (0 * math.cos(slip_rad)) - ( 550 * math.sin(slip_rad))
	y = (0 * math.sin(slip_rad)) + (550 * math.cos(slip_rad))
	
    img_move(img_ball, x + 128,y -523 ,nil,nil)
end

function new_ball_deflection_FSX(slip)
	
--slip = slip * -100
	slip = slip * -9
		print(slip)
	new_ball_deflection(slip)
	
end

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

fsx_variable_subscribe("TURN COORDINATOR BALL", "Position",new_ball_deflection_FSX)

fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	