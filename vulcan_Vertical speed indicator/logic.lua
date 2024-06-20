--   vulcan vario    ---

img_add_fullscreen("vario back.png")
img_night = img_add("vario back night.png", 0,0,400,400)
img_needle = img_add_fullscreen("vario_needle.png")

function PT_vario(verticalspeed)
    
    verticalspeed = var_cap(verticalspeed, -4000, 4000)
	
	if verticalspeed >= 3001 then 
   	 img_rotate(img_needle, 25 / 1000 * (verticalspeed) + 60)
	 elseif verticalspeed >= 2001 then 
   	  img_rotate(img_needle, 25 / 1000 * (verticalspeed - 1000) + 85)
	    elseif verticalspeed >= 1001 then 
   	     img_rotate(img_needle, 40 / 1000 * (verticalspeed - 1000) + 70) 
		    elseif verticalspeed >= 501 then 
   	         img_rotate(img_needle, 30 / 500 * (verticalspeed - 500) + 40)
			  elseif verticalspeed >= 000 then 
   	              img_rotate(img_needle, 40 / 500 * (verticalspeed - 500) + 40) 
				  
     elseif verticalspeed <= -3001 then 
   	 img_rotate(img_needle, 25 / 1000 * (verticalspeed) - 60 )	 
	   elseif verticalspeed <= -2001 then 
   	   img_rotate(img_needle, 25 / 1000 * (verticalspeed + 1000) - 85 )	
	     elseif verticalspeed <= -1001 then 
   	     img_rotate(img_needle, 40 / 1000 * (verticalspeed + 1000) - 70 )
		   elseif verticalspeed <= -501 then 
   	        img_rotate(img_needle, 30 / 500 * (verticalspeed + 500) - 40 )	
			 elseif verticalspeed <= 0000 then 
   	          img_rotate(img_needle, 40 / 500 * (verticalspeed + 500 ) - 40 )	  
	 end
end	 
	     
function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end
		 
-- Bus subscribe
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/vvi_fpm_pilot", "FLOAT", PT_vario)
fsx_variable_subscribe("VERTICAL SPEED", "Feet per minute", PT_vario)


fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	