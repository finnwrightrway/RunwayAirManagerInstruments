background_img = img_add_fullscreen ( "g meter.png" )
img_night = img_add("g meter night.png", 0,0,200,200)
min_needle = img_add_fullscreen ( "needle_min.png" )
max_needle = img_add_fullscreen ( "needle_max.png"  )
move_needle = img_add_fullscreen ( "needle_moving.png"  )
g_max=1
g_min=1

function  reset_needles()
img_rotate ( min_needle , 0) 
img_rotate ( max_needle , 0)
g_max=1
g_min=1
end

reset_button = button_add ( "set_knob.png"  , "set_knob_pressed.png" , 23 , 403 , 83 , 83 , reset_needles )
cockpit_button=hw_button_add("Reset", reset_needles)

function g_changed ( g_val  )
g_val = var_cap ( g_val , -4, 6)
if g_val < g_min then img_rotate ( min_needle , (g_val - 1) * 240/12 ) g_min= g_val end
if g_val > g_max then img_rotate ( max_needle , (g_val - 1) * 240/12 ) g_max= g_val end
end

function g_changing ( g_val  )
g_val = var_cap ( g_val , -4, 6)

img_rotate ( move_needle , (g_val - 1) * 240/12 )

end

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

xpl_dataref_subscribe( "sim/flightmodel/forces/g_nrml" , "FLOAT" ,  g_changed )
fsx_variable_subscribe( "G FORCE", "GForce", g_changed )
fsx_variable_subscribe( "G FORCE", "GForce", g_changing )

fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	