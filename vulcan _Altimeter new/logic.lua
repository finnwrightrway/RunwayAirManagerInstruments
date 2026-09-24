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
  return math.abs(i) % 10
end
alt_10000_running_txt_id = running_txt_add_ver(52,89,3,24,47,alt_10000_value_callback,font_alt)
viewport_rect(alt_10000_running_txt_id, 51,140, 25, 47)
 
function alt_1000_value_callback(i)
  return math.abs(i) % 10
end 
alt_1000_running_txt_id = running_txt_add_ver(85,89,3,22,47,alt_1000_value_callback,font_alt)
viewport_rect(alt_1000_running_txt_id, 84,140, 25, 47)

function alt_100_value_callback(i)
  return math.abs(i) % 10
end
alt_100_running_txt_id = running_txt_add_ver(117,89,3,22,47,alt_100_value_callback,font_alt)
viewport_rect(alt_100_running_txt_id, 116,130, 25, 77)

function alt_10_value_callback(i)
  local idx = math.abs(i) % 5
  local value = (4 - idx) * 20 + 20
  if value == 100 then
    value = 0
  end
  return string.format("%02d", value) 
end
alt_10_running_txt_id = running_txt_add_ver(197,49,3,52,43,alt_10_value_callback,font_alt)
viewport_rect(alt_10_running_txt_id, 196,48, 60, 43)

--flags
---------------------------------------------
img_ground_flag= img_add("atr_alt_ground_flag.png",50,148,28,38)
img_negative_flag = img_add("atr_alt_neg_flag.png",50,148,60,38)
img_off=img_add("atr_alt_off_flag.png",70,101,55,20)

-- pressure setting mbar
-- mb drum display 
---------------------------------------------
function mb_1_value_callback(i)
  return "" .. math.abs(i) % 10
end
drum_mb_1 = running_txt_add_ver(242,175,3,24,24,mb_1_value_callback,font_baro)
viewport_rect(drum_mb_1, 240,200, 24, 24)

function mb_2_value_callback(i)
  return "" .. math.abs(i) % 10
end
drum_mb_2 = running_txt_add_ver(226,175,3,24,24,mb_2_value_callback,font_baro)
viewport_rect(drum_mb_2,  224,200, 24, 24)

function mb_3_value_callback(i)
  return "" .. math.abs(i) % 10
end
drum_mb_3 = running_txt_add_ver(210,175,3,24,24,mb_3_value_callback,font_baro)
viewport_rect(drum_mb_3,  208,200, 24, 24)

function mb_4_value_callback(i)
  return "" .. math.abs(i) % 10
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
  
  -- Calculate drum positions (positive values for callbacks)
  ----------------------------------
  local drum_10000 = math.floor(altitude / 10000) % 10
  local drum_1000 = math.floor(altitude / 1000) % 10
  local drum_100 = math.floor(altitude / 100) % 10
  local drum_10 = math.floor(altitude / 10) % 10
  
  -- Move drums with proper sign (negative for downward scroll direction)
  running_txt_move_carot(alt_10000_running_txt_id, drum_10000 * -1)
  running_txt_move_carot(alt_1000_running_txt_id, drum_1000 * -1)
  running_txt_move_carot(alt_100_running_txt_id, drum_100 * -1)
  running_txt_move_carot(alt_10_running_txt_id, drum_10 * -1)

  -- Baro drums (inHg × 100)
  ------------------------------
  local baro_integer = math.floor(fsx_baro * 100)
  local mb_1 = baro_integer % 10
  local mb_2 = math.floor(baro_integer / 10) % 10
  local mb_3 = math.floor(baro_integer / 100) % 10
  local mb_4 = math.floor(baro_integer / 1000) % 10
  
  running_txt_move_carot(drum_mb_1, mb_1 * -1)
  running_txt_move_carot(drum_mb_2, mb_2 * -1)
  running_txt_move_carot(drum_mb_3, mb_3 * -1)
  running_txt_move_carot(drum_mb_4, mb_4 * -1)
  
  -- Flags visibility  
  ------------------------------
  if altitude < 0 then 
    img_visible(img_negative_flag,true)
    img_visible(img_ground_flag,false)
  elseif altitude < 10000 then
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

function light_fsx(lightpanel)
  visible(img_night, lightpanel)
end

fsx_variable_subscribe("INDICATED ALTITUDE", "Feet",
                       "KOHLSMAN SETTING HG", "inHg", 
                       "KOHLSMAN SETTING MB", "Millibars",
                       "ELECTRICAL MASTER BATTERY", "BOOLEAN", new_fsx_data)
                       
fsx_variable_subscribe("LIGHT PANEL", "bool",
                       light_fsx)

xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/altitude_ft_pilot", "FLOAT", 
                      "sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot", "FLOAT",
                      "sim/cockpit/electrical/battery_on", "INT", new_xpl_data)