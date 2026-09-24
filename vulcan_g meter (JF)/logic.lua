background_img = img_add_fullscreen ( "g meter.png" )
img_night = img_add("g meter night.png", 0,0,200,200)
min_needle = img_add_fullscreen ( "needle_min.png" )
max_needle = img_add_fullscreen ( "needle_max.png"  )
move_needle = img_add_fullscreen ( "needle_moving.png"  )

function  reset_needles()
img_rotate ( min_needle , 0) 
img_rotate ( max_needle , 0)

end



function g_changed (g_max, g_min)


img_rotate ( min_needle , (g_min - 1) * 240/12 ) 


img_rotate ( max_needle , (g_max - 1) * 240/12 ) 

end

function g_changing ( g_val  )
g_val = var_cap ( g_val , -4, 6)

img_rotate ( move_needle , (g_val - 1) * 240/12 )

end



xpl_dataref_subscribe( "sim/flightmodel/forces/g_nrml" , "FLOAT" ,  g_changing )
xpl_dataref_subscribe( "thranda/gforce/Gmax" , "FLOAT", "thranda/gforce/Gmin" , "FLOAT" ,  g_changed )



	