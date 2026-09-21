-- vulcan altimeter --

-- Fonts
font_alt = "-fx-font-size:40px; -fx-font-family:London-Tube; -fx-font-weight:bold; -fx-fill: white; -fx-text-alignment:center;"
font_baro = "-fx-font-size:19px; -fx-font-family:London-Tube; -fx-font-weight:bold; -fx-fill: white; -fx-text-alignment:center;"

background_image_id = img_add_fullscreen("background.png")
img_night = img_add("background night.png", 0,0,330,330)

-- Barometric pressure set knob
---------------------------------------------
function dial_it(direction)  
  if direction == 1 then
	fsx_event("KOHLSMAN_INC")
	xpl_command("sim/instruments/barometer_up")
  elseif direction == -1 then
	fsx_event("KOHLSMAN_DEC")
	xpl_command("sim/instruments/barometer_down")
  end
end
baro_dial = dial_add("knob_mark.png",20,270,42,42,dial_it)
dial_click_rotate(baro_dial, 20)

-- Altimeter drum display
---------------------------------------------
function alt_10000_value_callback(i)
  return -i % 10
end
alt_10000_running_txt_id = running_txt_add_ver(52,89,3,24,47,alt_10000_value_callback,font_alt)
viewport_rect(alt_10000_running_txt_id, 51,140, 25, 47)
 
function alt_1000_value_callback(i)
  return -i % 10
end 
alt_1000_running_txt_id = running_txt_add_ver(85,89,3,22,47,alt_1000_value_callback,font_alt)
viewport_rect(alt_1000_running_txt_id, 84,140, 25, 47)

function alt_100_value_callback(i)
  return -i % 10
end
alt_100_running_txt_id = running_txt_add_ver(117,89,3,22,47,alt_100_value_callback,font_alt)
viewport_rect(alt_100_running_txt_id, 116,130, 25, 77)

function alt_10_value_callback(i)
	value = (4- (i%5)) * 20 + 20	-- interval of 20 feet
	if value == 100 then
		value = 0
	end
	return string.format("%02d", value) 
end
alt_10_running_txt_id = running_txt_add_ver(197,49,3,52,43,alt_10_value_callback,font_alt)
viewport_rect(alt_10_running_txt_id, 400,103, 60,33)

--flags
---------------------------------------------
img_ground_flag= img_add("atr_alt_ground_flag.png",50,148,28,38)
img_negative_flag = img_add("atr_alt_neg_flag.png",50,148,60,38)
img_off=img_add("atr_alt_off_flag.png",70,101,55,20)

-- pressure setting mbar
-- mb drum display 
---------------------------------------------
function mb_1_value_callback(i)
  return "" .. i % 10
end
drum_mb_1 = running_txt_add_ver(242,175,3,24,24,mb_1_value_callback,font_baro)
viewport_rect(drum_mb_1, 240,200, 24, 24)

function mb_2_value_callback(i)
  return "" .. i % 10
end
drum_mb_2 = running_txt_add_ver(226,175,3,24,24,mb_2_value_callback,font_baro)
viewport_rect(drum_mb_2,  224,200, 24, 24)

function mb_3_value_callback(i)
  return "" .. i % 10
end
drum_mb_3 = running_txt_add_ver(210,175,3,24,24,mb_3_value_callback,font_baro)
viewport_rect(drum_mb_3,  208,200, 24, 24)

function mb_4_value_callback(i)
  return "" .. i % 10
end
drum_mb_4 = running_txt_add_ver(194,175,3,24,24,mb_4_value_callback,font_baro)
viewport_rect(drum_mb_4, 192,200, 24, 24)

---------------------------------------------

img_needle = img_add("atr_alt_needle.png",0,0,330,330)

---------------------------------------------

function new_fsx_data(fsx_altitude, fsx_baro, fsx_baro_metric, fsx_battery)
  if fsx_battery then
	altitude = fsx_altitude
	img_visible(img_off,false)
	img_rotate(img_needle, (altitude - math.floor(altitude/10000)*10000)*0.36)
  else
	img_visible(img_off,true)
	img_rotate(img_needle,0)
	altitude = 0
  end
		
  -- determine altimeter drum values
  ----------------------------------
  drum_10_moving = (altitude / 20) + 20
  drum_100_stationary = math.floor(altitude / 100) 
  drum_100_moving = drum_100_stationary + drum_10_moving % 1
  drum_1000_stationary = math.floor(altitude / 1000)
  drum_1000_moving = drum_1000_stationary + drum_100_moving + 1
  drum_10000_stationary = math.floor(altitude / 10000) 
  drum_10000_moving = drum_10000_stationary + drum_1000_moving + 1 
  
  -- move the drums
  ------------------------------
  running_txt_move_carot(alt_10_running_txt_id, drum_10_moving * -1) 

  if (altitude % 100) > 80 then
	running_txt_move_carot(alt_100_running_txt_id, drum_100_moving * -1)
  else 
	running_txt_move_carot(alt_100_running_txt_id, drum_100_stationary * -1)
  end
 
  if (altitude % 1000) > 980 then
	running_txt_move_carot(alt_1000_running_txt_id, drum_1000_moving * -1)
  else 
	running_txt_move_carot(alt_1000_running_txt_id, drum_1000_stationary * -1)
  end
  
  if (altitude % 10000) > 9980 then
	running_txt_move_carot(alt_10000_running_txt_id, drum_10000_moving * -1)
  else 
	running_txt_move_carot(alt_10000_running_txt_id, drum_10000_stationary * -1)
  end

  --baro drums
  ------------------------------
  baro_integer = fsx_baro * 100
  baro1_moving = baro_integer % 10
  baro2_stationary = math.floor(baro_integer / 10)
  baro2_moving = baro2_stationary + baro1_moving + 1
  baro3_stationary = math.floor(baro_integer / 100)
  baro3_moving =  baro3_stationary + baro2_moving 
  baro4_stationary = math.floor(baro_integer / 1000)
  baro4_moving =  baro4_stationary + baro1_moving
  
  running_txt_move_carot(drum_baro_1, baro1_moving)

  if (baro_integer % 10) > 9 then
	  running_txt_move_carot(drum_baro_2, baro2_moving)
  else
      running_txt_move_carot(drum_baro_2, baro2_stationary)
  end

  if (baro_integer % 100) > 99 then
	  running_txt_move_carot(drum_baro_3, baro3_moving)
  else
      running_txt_move_carot(drum_baro_3, baro3_stationary)
  end

  if (baro_integer % 1000)  > 999 then
    running_txt_move_carot(drum_baro_4, baro4_moving)
  else
    running_txt_move_carot(drum_baro_4, baro4_stationary)
  end
    
  -- metric drums
  -----------------------------------
  metric1_moving = fsx_baro_metric % 10
  metric2_stationary = math.floor(fsx_baro_metric / 10)
  metric2_moving = metric2_stationary + metric1_moving + 1  
  metric3_stationary = math.floor(fsx_baro_metric / 100)
  metric3_moving = metric3_stationary + metric2_moving  
  metric4_stationary = math.floor(fsx_baro_metric / 1000)
  metric4_moving = metric4_stationary + metric3_moving
  
  running_txt_move_carot(drum_mb_1, metric1_moving)

  if (fsx_baro_metric % 10) > 9 then
	  running_txt_move_carot(drum_mb_2, metric2_moving)
  else
      running_txt_move_carot(drum_mb_2, metric2_stationary)
  end

  if (fsx_baro_metric % 100) > 99 then
	  running_txt_move_carot(drum_mb_3, metric3_moving)
  else
      running_txt_move_carot(drum_mb_3, metric3_stationary)
  end

  if (fsx_baro_metric % 1000)  > 999 then
    running_txt_move_carot(drum_mb_4, metric4_moving)
  else
    running_txt_move_carot(drum_mb_4, metric4_stationary)
  end
  
    -- flags visibility  
  ------------------------------
  if(altitude < 0) then 
	img_visible(img_negative_flag,true)
  elseif (altitude < 10000)  then
	img_visible(img_ground_flag,true)
	img_visible(img_negative_flag,false)
  else
	img_visible(img_ground_flag,false)
	img_visible(img_negative_flag,false)
  end
  
end	

function new_xpl_data(altitude, baro, battery)

	-- Convert boolean to integer
	battery = fif(battery == 1, true, false)
	
	-- Convert barometric setting in inHg to MB
	baro_metric = baro * 33.8637526

	new_fsx_data(altitude, baro, baro_metric, battery)
	
end

 function light_fsx(lightpanel )

      visible(img_night, lightpanel)	
end

fsx_variable_subscribe("INDICATED ALTITUDE", "Feet",
					   "KOHLSMAN SETTING HG", "inHg", 
					   "KOHLSMAN SETTING MB", "Millibars",
					   "ELECTRICAL MASTER BATTERY", "BOOLEAN", new_fsx_data)
					   
fsx_variable_subscribe("LIGHT PANEL", "bool",
					   light_fsx)	
			  					   				   
xpl_dataref_subscribe("sim/flightmodel/misc/h_ind", "FLOAT", 
					  "sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot", "FLOAT",
					  "sim/cockpit/electrical/battery_on", "INT", new_xpl_data)