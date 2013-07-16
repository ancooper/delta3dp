// Delta Ancooper 3D Printer

// Stepper holder (Nema17)

include <config.scad>;
use <corner.scad>;

da_sh_border_offset = da_co_outer_border_length*cos(30)-(da_co_outer_tube_radius-0.5*da_co_loaded_border_width)*sin(30);
da_sh_border_length = 2*(da_co_loaded_border_length*cos(30)+(da_co_inner_tube_radius-0.5*da_co_loaded_border_width)*sin(30));

module da_sh_result(){
	difference(){
		color(da_sh_color) union(){
			translate([da_sh_border_offset ,0 ,0]){
				cube([da_co_loaded_border_width, da_sh_border_length, da_sh_height], center = true);
				translate([0, 0.5*da_sh_border_length, 0]) cylinder(h = da_sh_height, r = 0.5*da_co_loaded_border_width, center = true);
				translate([0, -0.5*da_sh_border_length, 0]) cylinder(h = da_sh_height, r = 0.5*da_co_loaded_border_width, center = true);
			}
		}
		color(da_sh_color_diff) union(){
			translate([da_sh_border_offset+0.5*da_nema17_length-0.5*da_co_loaded_border_width+da_sh_border_width ,0 ,0])
				cube([da_nema17_length, da_nema17_width*da_epsilon, da_nema17_width*da_epsilon], center = true);
			translate([da_sh_border_offset ,0 ,0]){
				translate([0, 0.5*da_sh_border_length, 0]) cylinder(h = da_sh_height*da_epsilon, r = da_mount_holes_radius, center = true);
				translate([0, -0.5*da_sh_border_length, 0]) cylinder(h = da_sh_height*da_epsilon, r = da_mount_holes_radius, center = true);
				translate([0, 0.5*da_sh_border_length, 0]) cylinder(h = da_nema17_width*da_epsilon, r = 0.5*da_co_loaded_border_width*da_epsilon, center = true);
				translate([0, -0.5*da_sh_border_length, 0]) cylinder(h = da_nema17_width*da_epsilon, r = 0.5*da_co_loaded_border_width*da_epsilon, center = true);
				rotate([0, 90, 0]) cylinder(h = da_co_loaded_border_width*da_epsilon, r = da_nema17_spindle_radius, center = true);
				for(a = [0: 3]) rotate([45+90*a, 0, 0]) translate([0, 0, sqrt(2*da_nema17_mount_offset*da_nema17_mount_offset)]) {
					hull(){
						translate([0, 0, 2*da_mount_holes_radius]) rotate([0, 90, 0]) cylinder(h = da_co_loaded_border_width*da_epsilon, r = da_mount_holes_radius, center = true);
						translate([0, 0, -2*da_mount_holes_radius]) rotate([0, 90, 0]) cylinder(h = da_co_loaded_border_width*da_epsilon, r = da_mount_holes_radius, center = true);
					}
				}
			}
		}
	}
}

//translate([0, 0, 0.5*(da_co_height+da_sh_height)]) da_co_result();
//translate([0, 0, -0.5*(da_co_height+da_sh_height)]) da_co_result();
da_sh_result();