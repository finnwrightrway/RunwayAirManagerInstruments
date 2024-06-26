-- Load and display text and images
img_add_fullscreen("casing.png")
img_moving_dial = img_add_fullscreen("moving_dial.png")
img_plane = img_add_fullscreen("glass.png")


-- Callback functions (handles data received from X-plane)



-- subscribe functions on the AirBus
xpl_dataref_subscribe("sim/cockpit/gyros/psi_vac_ind_degm", "FLOAT", new_rotation)
fsx_variable_subscribe("HEADING INDICATOR", "Degrees", new_rotation)
fs2020_variable_subscribe("HEADING INDICATOR", "Degrees", new_rotation)