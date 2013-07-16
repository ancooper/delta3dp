// Ancooper delta 3D printer

// Properties

anc_inner_rod_radius = 5;
anc_outer_rod_radius = 5;
anc_link_radius = 4;
anc_rods_distance = 50;
anc_mount_holes_radius = 1.5;
anc_mount_caps_radius = 3;
anc_mount2_holes_radius = 4;
anc_mount2_caps_hex = 6.4;
anc_mount2_caps_radius = 8;
anc_mount2_caps_height = 6.25;
anc_nema17_width = 43; // 42.2 datasheet
anc_nema17_length = 34; // 33.8 datasheet
anc_nema17_mount_offset = 15.52;
anc_nema17_spindle_radius = 12; // 11 datasheet
anc_bearing_width = 2;
anc_bearing_outer_radius = 3.5;
anc_bearing_inner_radius = 1.5;
anc_bearing_air = 0.25;
anc_sphere_radius = 6;

anc_printer_height = 480; // 640
anc_printer_radious = 160;
anc_printer_stand_height = 10;
anc_printer_rod_color = "Gray";
anc_printer_link_color = "Gray";

anc_corner_height = 20;
anc_corner_loaded_border_width = 6;
anc_corner_outer_border_width = 3;
anc_corner_inner_border_width = 2;
anc_corner_outer_rod_border_width = 5;
anc_corner_inner_rod_border_width = 5;
anc_corner_outer_tube_radius = anc_outer_rod_radius+anc_corner_outer_rod_border_width;
anc_corner_inner_tube_radius = anc_inner_rod_radius+anc_corner_inner_rod_border_width;
anc_corner_color = "LightSteelBlue";

anc_corner_outer_border_length = anc_rods_distance*cos(30)+anc_inner_rod_radius+anc_corner_inner_rod_border_width-0.5*anc_corner_loaded_border_width;
anc_corner_loaded_border_length = anc_rods_distance*sin(30)+anc_corner_outer_tube_radius-0.5*anc_corner_loaded_border_width;
anc_corner_link_offset = 0.5*(anc_corner_loaded_border_length+0.5*anc_corner_loaded_border_width-anc_corner_inner_tube_radius+anc_corner_outer_border_width);

anc_stepper_holder_height = 50;
anc_stepper_holder_border_width = 3;
anc_stepper_holder_color = "DimGray";
anc_stepper_holder_color_diff = "CadetBlue";

anc_carriage_bearing_offset = 25;
anc_carriage_sphere_offset = 25;
anc_carriage_tube_border_offset = 1;
anc_carriage_tube_border_width = 2;
