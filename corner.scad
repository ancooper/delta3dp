// Ancooper delta 3D printer

include <config.scad>;
include <properties.scad>;
use <functions.scad>;

// Corner v1

module anc_corner_half_borders(){
	translate([0.5*anc_rods_distance, 0.5*anc_corner_outer_border_width]) 
		anc_rail(anc_rods_distance, anc_corner_outer_border_width, 0.5*anc_corner_inner_border_width, anc_corner_height, 0.5*anc_corner_inner_border_width);
	rotate([0, 0, 210]) translate([-0.5*anc_corner_outer_border_length, anc_corner_outer_border_width-anc_corner_outer_tube_radius, 0])
		anc_rail(anc_corner_outer_border_length, 2*anc_corner_outer_border_width, anc_corner_outer_border_width, anc_corner_height, 0.5*anc_corner_inner_border_width);
	translate([anc_rods_distance, 0, 0]) rotate([0, 0, 30]) translate([anc_corner_inner_tube_radius-anc_corner_loaded_border_width, 0, -0.5*anc_corner_height]) 
		difference() {
			cube([anc_corner_loaded_border_width, anc_corner_loaded_border_length, anc_corner_height]);
			translate([0.5*anc_corner_loaded_border_width, anc_corner_loaded_border_length+0.5*anc_corner_loaded_border_width-anc_corner_link_offset , 0.5*anc_corner_height]) rotate([0, 90, 0])
				cylinder(h = anc_corner_loaded_border_width*anc_epsilon, r = anc_mount2_holes_radius, center = true);
		}
}

module anc_corner_borders(){
	anc_corner_half_borders();
	mirror([0, 1, 0])
		anc_corner_half_borders();
}

module anc_corner_tubes(){
	cylinder(r = anc_corner_outer_tube_radius, h = anc_corner_height, center = true);
	translate([anc_rods_distance ,0, 0]) cylinder(r = anc_corner_inner_tube_radius, h = anc_corner_height, center = true);
	rotate([0, 0, 30]) translate([anc_corner_outer_border_length, anc_corner_outer_tube_radius-0.5*anc_corner_loaded_border_width, 0]) 
		cylinder(r = 0.5*anc_corner_loaded_border_width, h = anc_corner_height, center = true);
	rotate([0, 0, -30]) translate([anc_corner_outer_border_length, 0.5*anc_corner_loaded_border_width-anc_corner_outer_tube_radius, 0]) 
		cylinder(r = 0.5*anc_corner_loaded_border_width, h = anc_corner_height, center = true);
}

module anc_corner_holes(){
	cylinder(r = anc_outer_rod_radius, h = anc_corner_height*anc_epsilon, center = true);
	translate([anc_rods_distance ,0, 0]) cylinder(r = anc_inner_rod_radius, h = anc_corner_height*anc_epsilon, center = true);
	rotate([0, 0, 30]) translate([anc_corner_outer_border_length, anc_corner_outer_tube_radius-0.5*anc_corner_loaded_border_width, 0]) 
		cylinder(r = anc_mount_holes_radius, h = anc_corner_height*anc_epsilon, center = true);
	rotate([0, 0, -30]) translate([anc_corner_outer_border_length, 0.5*anc_corner_loaded_border_width-anc_corner_outer_tube_radius, 0]) 
		cylinder(r = anc_mount_holes_radius, h = anc_corner_height*anc_epsilon, center = true);
}

module anc_corner_rodmount(length){
	rotate([90, 0, 0]){
		cylinder(h = 4*length, r = anc_mount_holes_radius, center = true);
		translate([0, 0, 2*length]) cylinder(h = 2*length, r = anc_mount_caps_radius, center = true);
		translate([0, 0, -2*length]) cylinder(h = 2*length, r = anc_mount_caps_radius, center = true);
	}
}


module anc_corner_rodmount_holes(){
	translate([-anc_outer_rod_radius-0.5*anc_corner_outer_rod_border_width, 0, 0]) cube([2*anc_corner_outer_rod_border_width, 2, anc_corner_height*anc_epsilon], center = true);
	translate([anc_rods_distance+anc_inner_rod_radius+0.5*anc_corner_inner_rod_border_width, 0, 0]) cube([2*anc_corner_inner_rod_border_width, 2, anc_corner_height*anc_epsilon], center = true);
	translate([-anc_outer_rod_radius-1.5, 0, 0.25*anc_corner_height]) anc_corner_rodmount(anc_outer_rod_radius);
	translate([-anc_outer_rod_radius-1.5, 0, -0.25*anc_corner_height]) anc_corner_rodmount(anc_outer_rod_radius);
	translate([anc_rods_distance+anc_inner_rod_radius+1.5, 0, 0.25*anc_corner_height]) anc_corner_rodmount(anc_inner_rod_radius);
	translate([anc_rods_distance+anc_inner_rod_radius+1.5, 0, -0.25*anc_corner_height]) anc_corner_rodmount(anc_inner_rod_radius);
}

module anc_corner(){
	difference(){
		union(){
			anc_corner_borders();
			anc_corner_tubes();
		}
		union(){
			anc_corner_holes();
			anc_corner_rodmount_holes();
		}
	}
}

// Corner v2

module anc_corner_ear(){
	difference(){
		translate([4, 0, 0]) rotate([0, 0, -30]) translate([-25, 4, 0]) difference(){
			union(){
				rotate([-90, 0, 0]) cylinder(h = 8, r = 7, center = true);
				translate([20, 0, 0]) cube([40, 8, 14], center = true);
			}
			rotate([-90, 0, 0]) cylinder(h = 8.1, r = 4, center = true);
		}
		translate([4, -10, -10]) cube([20, 10, 20]);
	}
}

module anc_corner_v2(){
	translate([-12, 0, 0]) difference(){
		intersection(){
			union(){
				anc_corner_ear();
				mirror([0, 1, 0]) anc_corner_ear();
				cylinder(h = 14, r = 10, center = true);
			}
			hull(){
				translate([8, 1, 0]) rotate([-90, 0, 0]) cylinder(h = 50, r = 7, center = true);
				translate([-18, 1, 0]) rotate([-90, 0, 0]) cylinder(h = 50, r = 7, center = true);
			}
		}
		cylinder(h = 14.1, r = 5, center = true);
		translate([8, 0, 0]) cube([16, 2, 14.1], center = true);
		translate([8, 0, 0]) rotate([90, 0, 0]) cylinder(h = 10, r = 1.5, center = true);
		translate([8, 7, 0]) rotate([90, 0, 0]) cylinder(h = 6, r = 3, center = true);
		translate([8, -7, 0]) rotate([90, 0, 0]) cylinder(h = 6, r = 3, center = true);
	}
}

// Test

//anc_corner_half_borders();
//anc_corner_borders();
//anc_corner_tubes();
//anc_corner_holes();
//anc_corner();

//anc_corner_ear
//anc_corner_v2();
