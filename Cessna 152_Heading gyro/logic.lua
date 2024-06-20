img_add_fullscreen("background.png")
img_heading = img_add_fullscreen("heading_disc.png")
img_add_fullscreen("angles.png")

function new_data(heading)

    rotate(img_heading, heading * -1)

end

dial_add("gyro_dial.png", 4, 412, 96, 96, function(direction)

    if direction == 1 then
        fs2020_event("GYRO_DRIFT_DEC")
        fsx_event("GYRO_DRIFT_DEC")
        xpl_command("sim/instruments/DG_sync_down")
    else
        fs2020_event("GYRO_DRIFT_INC")
        fsx_event("GYRO_DRIFT_INC")
        xpl_command("sim/instruments/DG_sync_up")
    end

end)

fs2020_variable_subscribe("HEADING INDICATOR", "Degrees", new_data)
fsx_variable_subscribe("HEADING INDICATOR", "Degrees", new_data)
xpl_dataref_subscribe("sim/cockpit/gyros/the_vac_ind_deg", "FLOAT", new_data)