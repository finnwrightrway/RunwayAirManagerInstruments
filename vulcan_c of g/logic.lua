-- vulcan c of g ----

img_add_fullscreen("c of g back.png")
--img_night = img_add("c of g back night.png", 0,0,400,400)
img_right = img_add("gravity right needle.png",227,190,290,21)
img_left = img_add("gravity left needle.png",-116,190,290,21)

function PT_gravity_FSX (cg)

       cg = var_cap(cg, -100,100)

       img_rotate(img_right, cg * .33)
       img_rotate(img_left, -cg * .33)
end

function PT_night_FSX (lightpanel)

 visible(img_night, lightpanel)

end 

fsx_variable_subscribe("CG PERCENT", "Percent",
                        PT_gravity_FSX)
						
-- This is where we check if the backlight (cockpit light) is on, currently disabled, re-enable when req, and set up for x-plane --

-- fsx_variable_subscribe("LIGHT PANEL", "bool",
--				   light_fsx)			