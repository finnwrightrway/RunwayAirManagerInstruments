-- Load and display text and images
img_add_fullscreen("casing.png")
img_moving_dial = img_add("moving_dial.png", 31, 31, 450, 450)
img_plane = img_add("glass.png", 26, 26, 460, 460)


-- Callback functions (handles data received from X-plane)

function new_rotation(rotation)
    rotate(img_moving_dial, rotation *-1)
end

-- subscribe functions on the AirBus
xpl_dataref_subscribe("sim/cockpit/gyros/psi_vac_ind_degm", "FLOAT", new_rotation)
fsx_variable_subscribe("HEADING INDICATOR", "Degrees", new_rotation)
fs2020_variable_subscribe("HEADING INDICATOR", "Degrees", new_rotation)