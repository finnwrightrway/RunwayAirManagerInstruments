-- Global variables --
local persist_power = persist_add("power", "INT", 0)
local gbl_power  = 0
local gbl_dist1  = 0

-- Add images in Z-order --

img_add_fullscreen("trim_dme_back.png")
--img_night = img_add("trim_dme_back_night.png", 0,0,256,256)

-- Add text  in Z-order --

txt_load_font("GOST Common.ttf")

txt_naut = txt_add(" ", "-fx-font-size:30px; -fx-fill: #FFFF00; -fx-text-alignment: RIGHT;", -3, 27, 150, 150)
txt_nm = txt_add("NM", "-fx-font-size:12px; -fx-font-family:\"GOST Common\"; -fx-fill: #FFFF00; -fx-text-alignment: LEFT;", 149, 42, 50, 50)

-- Add a group --
group_text = group_add(txt_naut, txt_nm)

-- Functions --
function update_gui()

    -- Get the state of the power switch
    selected = persist_get(persist_power)
    -- Turn DME on and off (make text visible and invisible)
    visible(group_text, gbl_power)

    -- Are we seeing data from DME1
    visible(txt_nav1, gbl_power)
    
    -- Set distance
    if selected == 1 then
        distance = var_cap(gbl_dist1, 0, 999.9)
    elseif selected == 2 then
        distance = var_cap(gbl_dist2, 0, 999.9)
    else
        distance = 0
    end
print(distance)
    if distance >= 10 then
        txt_set(txt_naut, var_format(distance, 1) )
    elseif distance < 10 then
        txt_set(txt_naut, "0" .. var_format(distance, 1) )
    end

end

function new_data_fsx(dist1, avionics, battery)

    -- Do we have power?
    gbl_power = fif((battery and avionics), true, false)
	pwr_on=fif( gbl_power, 1,0)
persist_put(persist_power, pwr_on)
    -- Make everything global
    gbl_dist1  = dist1

    update_gui()
    
end

-- Subscribe to data --

fsx_variable_subscribe("NAV DME:1", "nautical mile",
                       "CIRCUIT AVIONICS ON", "Bool",
                       "ELECTRICAL MASTER BATTERY", "Bool", new_data_fsx)
                       
update_gui()     


                 --- vulcan trim and dme ------

--img_add_fullscreen("trim_dme_back.png")
img_aileron = img_add("aileron.png",0,0,256,256)
img_rudder = img_add("rudder.png",0,0,256,256)
img_elevator = img_add("elevator.png",0,0,256,256)

-- Functions --

--- trim -----
function PT_trim(aileron,rudder,elevator)
	img_rotate(img_aileron, aileron*40)
	img_rotate(img_rudder, rudder*40)
	img_rotate(img_elevator, elevator*40)
end

function PT_trim_FSX(elevator, aileron, rudder)

	elevator = elevator / 100
	aileron = aileron / 100
	rudder = rudder / 100
	
	PT_trim(aileron, rudder, elevator)

end

-------lighting---------

function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

-- Subscribe to data --					  
					  
fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	

fsx_variable_subscribe("ELEVATOR TRIM PCT", "Percent",
					   "AILERON TRIM PCT", "Percent",
					   "RUDDER TRIM PCT", "Percent", PT_trim_FSX)
					    