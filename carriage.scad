// Delta Ancooper 3D Printer

// Carriage

include <config.scad>;

da_cr_inner_tube_radius = da_inner_rod_radius+da_cr_tube_border_offset+da_cr_tube_border_width;
da_cr_outer_tube_radius = da_outer_rod_radius+da_cr_tube_border_offset+da_cr_tube_border_width;

module da_cr_rods(color = da_pr_rod_color){
	color(color){
		cylinder(h = 100, r = da_outer_rod_radius, center = true);
		translate([da_rods_distance, 0, 0]) cylinder(h = 100, r = da_outer_rod_radius, center = true);
	}
}

module da_bearing(width = da_bearing_width, r1 = da_bearing_outer_radius, r2 = da_bearing_inner_radius, center = true, color = "SteelBlue"){
	color(color) difference(){
		cylinder(h = width, r = r1, center = center);
		cylinder(h = width*da_epsilon, r = r2, center = center);
	}
}

module da_cr_bearing_on_rod(offset = 0, angle = 0){
	rotate([0, 0, angle]) translate([da_outer_rod_radius+da_bearing_outer_radius, 0, offset]) rotate([90, 0, 0]) da_bearing(center = true);
}

module da_cr_bearings(){
	da_cr_bearing_on_rod(angle = 90);
	da_cr_bearing_on_rod(angle = -90);
	translate([da_rods_distance, 0, 0]){
		da_cr_bearing_on_rod(da_cr_bearing_offset, angle = 60);
		da_cr_bearing_on_rod(da_cr_bearing_offset, angle = -60);
		da_cr_bearing_on_rod(-da_cr_bearing_offset, angle = 60);
		da_cr_bearing_on_rod(-da_cr_bearing_offset, angle = -60);
		da_cr_bearing_on_rod(angle = 180);
	}
}

module da_spheres(r = da_sphere_radius, color = "SteelBlue"){
	color(color){
		translate([da_rods_distance, da_cr_sphere_offset, 0]) sphere(r);
		translate([da_rods_distance, -da_cr_sphere_offset, 0]) sphere(r);
	}
}

module da_cr_bearing_holder(){
	cylinder(h = 2*da_bearing_width, r = da_mount_caps_radius);
	translate([0, 0, -da_bearing_air]) cylinder(h = da_bearing_air, r = da_bearing_inner_radius+0.5);
}

module da_cr_outer_tube(){
	difference(){
		union(){
			translate([0.5*da_bearing_width+da_bearing_air, (da_outer_rod_radius+da_bearing_outer_radius), 0]) rotate([0, 90, 0]) da_cr_bearing_holder();
			intersection(){
				cylinder(h = 2*da_mount_caps_radius, r = da_outer_rod_radius+da_cr_tube_border_offset+da_cr_tube_border_width, center = true);
				translate([0.5*da_bearing_width+da_bearing_air, 1, -da_mount_caps_radius*da_epsilon]) 
					cube([da_cr_outer_tube_radius, da_cr_outer_tube_radius, 2*da_mount_caps_radius*da_epsilon]);
			}
			translate([0, 1, -da_mount_caps_radius]) cube([2*da_cr_outer_tube_radius, da_cr_bridge_width-1, 2*da_mount_caps_radius]);
			translate([2*da_cr_outer_tube_radius, 0, -da_mount_caps_radius]) cube([0.5*da_rods_distance-2*da_cr_outer_tube_radius, da_cr_bridge_width, 2*da_mount_caps_radius]);
		}
		translate([0.5*da_bearing_width-da_bearing_air, da_outer_rod_radius+da_bearing_outer_radius, 0]) rotate([0, 90, 0]) 
			cylinder(h = 4*da_bearing_width, r = da_mount_holes_radius-0.25);
	}
}

module da_cr_half_result(){
	difference(){
		union(){
			da_cr_outer_tube();
			translate([da_cr_outer_tube_radius+da_mount_caps_radius, 1, 0]) rotate([-90, 0, 0]) cylinder(h = 2*da_bearing_width, r = da_mount_caps_radius);
			translate([da_rods_distance, 0, 0]) union(){
				rotate([0, 0, -30]) translate([0.5*da_bearing_width+da_bearing_air, (da_outer_rod_radius+da_bearing_outer_radius), da_cr_bearing_offset]) rotate([0, 90, 0]) da_cr_bearing_holder();
				rotate([0, 0, -30]) translate([0.5*da_bearing_width+da_bearing_air, (da_outer_rod_radius+da_bearing_outer_radius), -da_cr_bearing_offset]) rotate([0, 90, 0]) da_cr_bearing_holder();
				intersection(){
					cylinder(h = 2*(da_cr_bearing_offset+da_mount_caps_radius), r = da_outer_rod_radius+da_cr_tube_border_offset+2*da_cr_tube_border_width, center = true);
					union(){
						translate([0.5*da_bearing_width+da_bearing_air, 1, -(da_cr_bearing_offset+da_mount_caps_radius)]) 
							cube([da_cr_outer_tube_radius, da_cr_outer_tube_radius, 2*(da_cr_bearing_offset+da_mount_caps_radius)]);
						translate([0.5*da_bearing_width+da_bearing_air, 0, -(da_cr_bearing_offset-da_mount_caps_radius-da_cr_inner_tube_radius)]) 
							cube([da_cr_outer_tube_radius, da_cr_outer_tube_radius, 2*(da_cr_bearing_offset-da_mount_caps_radius-da_cr_inner_tube_radius)]);
					}
					rotate([0, 0, -30]) translate([0.5*da_bearing_width+da_bearing_air, 1, -(da_cr_bearing_offset+da_mount_caps_radius)*da_epsilon]) 
						cube([da_cr_outer_tube_radius, da_cr_outer_tube_radius, 2*(da_cr_bearing_offset+da_mount_caps_radius)]);
				}
				cylinder(h = 2*(da_cr_bearing_offset-da_mount_caps_radius-da_cr_inner_tube_radius), r = da_outer_rod_radius+da_cr_tube_border_offset+da_cr_tube_border_width, center = true);
				rotate([-90, 0, 0]) 
					difference(){
						intersection(){
							union(){
								translate([0, 0, 0.5*(da_cr_sphere_offset-da_sphere_radius)]) cube([2*da_cr_inner_tube_radius, 2, da_cr_sphere_offset-da_sphere_radius], center = true);
								translate([0, 0, 0.5*(da_cr_sphere_offset-da_sphere_radius)]) cube([2, 2*da_cr_inner_tube_radius, da_cr_sphere_offset-da_sphere_radius], center = true);
								cylinder(h = da_cr_sphere_offset-da_sphere_radius, r = da_mount_caps_radius);
							}
							cylinder(h = da_cr_sphere_offset-da_sphere_radius, r1 = da_cr_inner_tube_radius+0.5, r2 = da_mount_caps_radius+0.5);
						}
						cylinder(h = da_cr_sphere_offset*da_epsilon-da_sphere_radius, r = da_mount_holes_radius);
					}
			}
		}
		union(){
			cylinder(h = 2*da_mount_caps_radius*da_epsilon, r = da_outer_rod_radius+da_cr_tube_border_offset, center = true);
			translate([da_cr_outer_tube_radius+da_mount_caps_radius, 0, 0]) rotate([-90, 0, 0]) cylinder(h = 4*da_bearing_width, r = da_mount_holes_radius-0.25);

			translate([da_rods_distance, 0, 0]) cylinder(h = 2*(da_cr_bearing_offset+da_mount_caps_radius)*da_epsilon, r = da_outer_rod_radius+da_cr_tube_border_offset, center = true);
			translate([-da_cr_outer_tube_radius, +0.01, -(da_cr_bearing_offset+da_bearing_outer_radius)]) mirror([0, 1, 0]) 
				cube([da_rods_distance+da_cr_inner_tube_radius+da_cr_outer_tube_radius, da_cr_sphere_offset, 2*(da_cr_bearing_offset+da_bearing_outer_radius)]);
		}
	}
}

module da_cr_result(){
	da_cr_half_result();
	rotate([180, 0, 0]) da_cr_half_result();	
	//da_cr_belt_holder();
}

da_cr_rods();
da_cr_bearings();
da_spheres();
da_cr_result();