// Ancooper delta 3D printer

include <config.scad>;
include <properties.scad>;
use <functions.scad>;

// Carriage

anc_carriage_inner_tube_radius = anc_inner_rod_radius+anc_carriage_tube_border_offset+anc_carriage_tube_border_width;
anc_carriage_outer_tube_radius = anc_outer_rod_radius+anc_carriage_tube_border_offset+anc_carriage_tube_border_width;
anc_carriage_bearing_space = 0.5*anc_bearing_7x3x2_width+anc_bearing_7x3x2_air;

module anc_carriage_rods(){
	color("SlateGray"){
		cylinder(h = 100, r = anc_outer_rod_radius, center = true);
		translate([anc_rods_distance, 0, 0]) cylinder(h = 100, r = anc_inner_rod_radius, center = true);
	}
}

module anc_carriage_bearing_on_rod(rod_radius, offset = 0, angle = 0){
	rotate([0, 0, angle]) translate([rod_radius+anc_bearing_7x3x2_outer_radius, 0, offset]) rotate([90, 0, 0]) anc_bearing_7x3x2();
}

module anc_carriage_bearings(){
	anc_carriage_bearing_on_rod(anc_outer_rod_radius, angle = 90);
	anc_carriage_bearing_on_rod(anc_outer_rod_radius, angle = -90);
	translate([anc_rods_distance, 0, 0]){
		anc_carriage_bearing_on_rod(anc_inner_rod_radius, anc_carriage_bearing_offset, angle = 120);
		anc_carriage_bearing_on_rod(anc_inner_rod_radius, anc_carriage_bearing_offset, angle = -120);
		anc_carriage_bearing_on_rod(anc_inner_rod_radius, anc_carriage_bearing_offset, angle = 0);
		anc_carriage_bearing_on_rod(anc_inner_rod_radius, -anc_carriage_bearing_offset, angle = 120);
		anc_carriage_bearing_on_rod(anc_inner_rod_radius, -anc_carriage_bearing_offset, angle = -120);
		anc_carriage_bearing_on_rod(anc_inner_rod_radius, -anc_carriage_bearing_offset, angle = 0);
	}
}

module anc_carriage_tube_hole(c){
	hull() for(i=[-c, c]){
			translate([0, 0, i*anc_bearing_7x3x2_outer_radius]) scale([1, 1, anc_bearing_7x3x2_outer_radius/anc_carriage_bearing_space]) 
				rotate([0, 90, 0]) cylinder(h = anc_carriage_inner_tube_radius*anc_epsilon, r = anc_carriage_bearing_space);
	}
}

module anc_carriage_bearing_holder(){
	translate([-anc_mount_caps_radius, -anc_mount_caps_radius, 0]) cube([anc_mount_caps_radius, 2*anc_mount_caps_radius, 2*anc_bearing_7x3x2_width]);
	cylinder(h = 2*anc_bearing_7x3x2_width, r = anc_mount_caps_radius);
	translate([0, 0, -anc_bearing_7x3x2_air]) cylinder(h = 2*anc_bearing_7x3x2_air, r = anc_bearing_7x3x2_inner_radius+0.5);
}

module anc_carriage_bearing_holder_holes(){
	cylinder(h = 2*(anc_bearing_7x3x2_width+anc_bearing_7x3x2_air)*anc_epsilon, r = anc_mount_holes_radius);
	translate([0, 0, 2*anc_bearing_7x3x2_width+anc_bearing_7x3x2_air]) cylinder(h = 0.5*anc_rods_distance, r = anc_mount_caps_radius*anc_epsilon);
}

module anc_carriage_sphere_holder(){
	rotate([90, 0, 0]) intersection(){
		hull(){ 
			scale([1, 2, 1]) cylinder(h = anc_carriage_inner_tube_radius, r = anc_carriage_inner_tube_radius);
			translate([0, 0, anc_carriage_inner_tube_radius]) cylinder(h = anc_carriage_sphere_offset-anc_carriage_inner_tube_radius-anc_sphere_radius, r = anc_mount_caps_radius);
		}
		union(){
			for(a=[0:90:270]) rotate([0, 0, a])
				translate([-0.5*anc_carriage_tube_border_width, 0, 0]) cube([anc_carriage_tube_border_width, 2*anc_carriage_inner_tube_radius, anc_carriage_sphere_offset]);
			cylinder(h = anc_carriage_sphere_offset-anc_sphere_radius, r1 = 2*anc_mount_caps_radius, r2 = anc_mount_caps_radius);
		}
	}
}

module anc_carriage_bridge_holes(){
	ro = [0, anc_carriage_outer_tube_radius];
	rm = [0.5*anc_rods_distance, 0.5*(anc_inner_rod_radius+anc_outer_rod_radius)];
	ri = [anc_rods_distance, anc_carriage_inner_tube_radius];
	ma = (rm[1]-ro[1])/(rm[0]-ro[0]);
	mb = (ri[1]-rm[1])/(ri[0]-rm[0]);
	x = (ma*mb*(ro[1]-ri[1])+mb*(ro[0]+rm[0])-ma*(rm[0]+ri[0]))/(2*(mb-ma));
	y = 0.5*(ro[1]-rm[1])-(x-0.5*(ro[0]+rm[0]))/ma;
	r = sqrt(pow(ro[0]-x, 2)+pow(ro[1]-y, 2));

	translate([x, y, 0]) cylinder(h =  2*anc_bearing_7x3x2_outer_radius*anc_epsilon, r = r, center = true, $fn = 256);
	translate([x, -y, 0]) cylinder(h =  2*anc_bearing_7x3x2_outer_radius*anc_epsilon, r = r, center = true, $fn = 256);

	for(o=[0.5*anc_rods_distance-2*anc_mount_caps_radius, 0.5*anc_rods_distance+2*anc_mount_caps_radius]){
		rotate([90, 0, 0]) translate([o, 0, 0]) cylinder(h = 2*max(anc_carriage_inner_tube_radius, anc_carriage_outer_tube_radius)*anc_epsilon, r = anc_mount_holes_radius, center = true);
		for(a=[-90, 90])
		rotate([a, 0, 0]) translate([o, 0, min(anc_inner_rod_radius, anc_outer_rod_radius)]) cylinder(h = max(anc_carriage_inner_tube_radius, anc_carriage_outer_tube_radius)-min(anc_inner_rod_radius, anc_outer_rod_radius), r = anc_mount_caps_radius*anc_epsilon);
	}
}

module anc_carriage_bridge(){
	a = anc_rods_distance;
	l = anc_carriage_tube_border_width+anc_carriage_tube_border_offset;
	r = a*a/(8*l)+0.5*l;

	translate([0.25*anc_rods_distance, 0, 0]) cube([0.5*anc_rods_distance, 2*anc_carriage_inner_tube_radius, 2*anc_bearing_7x3x2_outer_radius], center = true);
}

module anc_carriage_inner_tube(){
	difference(){
		union(){
			rotate([0, 0, 180]) anc_carriage_bridge();
			cylinder(h = 2*(anc_carriage_bearing_offset+anc_bearing_7x3x2_outer_radius), r = anc_carriage_inner_tube_radius, center = true);
		}
		for(a=[0, 120, 240], o=[-anc_carriage_bearing_offset, anc_carriage_bearing_offset])
			rotate([0, 0, a]) translate([0, 0, o]) anc_carriage_tube_hole(1);
		for(a=[60, 180, 300], o=[-anc_carriage_bearing_offset, anc_carriage_bearing_offset])
			rotate([0, 0, a]) translate([0, 0, o]) anc_carriage_tube_hole(4);
		translate([-anc_rods_distance, 0, 0]) anc_carriage_bridge_holes();
	}
}

module anc_carriage_spheres(){
	color("LightSteelBlue")
		for(o=[-anc_carriage_sphere_offset, anc_carriage_sphere_offset])
			translate([anc_rods_distance, o, 0]) sphere(anc_sphere_radius);
}

module anc_carriage_outer_tube(){
	difference(){
		union(){
			anc_carriage_bridge();
			cylinder(h = 2*anc_bearing_7x3x2_outer_radius, r = anc_carriage_inner_tube_radius, center = true);
		}
		for(a=[90, 270])
			rotate([0, 0, a]) anc_carriage_tube_hole(1);
		translate([-0.5*anc_carriage_inner_tube_radius, 0, 0]) cube([anc_carriage_inner_tube_radius*anc_epsilon, 2*anc_carriage_inner_tube_radius*anc_epsilon, 2*anc_bearing_7x3x2_outer_radius*anc_epsilon], center = true);
		anc_carriage_bridge_holes();		
	}
}

module anc_carriage_inner_tube_with_holders(){
	difference(){
		union(){
			anc_carriage_inner_tube();
			for(a = [0, 120, 240], s = [-1, 1], o = [-anc_carriage_bearing_offset, anc_carriage_bearing_offset])
				rotate([0, 0, a]) scale([1, s, 1]) translate([anc_inner_rod_radius+anc_bearing_7x3x2_outer_radius, 0.5*anc_bearing_7x3x2_width+anc_bearing_7x3x2_air, o]) rotate([-90, 0, 0]) anc_carriage_bearing_holder();
			anc_carriage_sphere_holder();
		}
		cylinder(h = 2*(anc_carriage_bearing_offset+anc_bearing_7x3x2_outer_radius)*anc_epsilon, r = anc_inner_rod_radius+anc_carriage_tube_border_offset, center = true);
		for(a = [0, 120, 240], s = [-1, 1], o = [-anc_carriage_bearing_offset, anc_carriage_bearing_offset])
			rotate([0, 0, a]) scale([1, s, 1]) translate([anc_inner_rod_radius+anc_bearing_7x3x2_outer_radius, 0.5*anc_bearing_7x3x2_width-(anc_epsilon-1), o]) rotate([-90, 0, 0]) anc_carriage_bearing_holder_holes();
		rotate([90, 0, 0]) cylinder(h = (anc_carriage_sphere_offset-anc_sphere_radius)*anc_epsilon, r = anc_mount_holes_radius);
		rotate([90, 0, 0]) cylinder(h = anc_carriage_inner_tube_radius*anc_epsilon, r = anc_mount_caps_radius*anc_epsilon, $fn=6);
	}
}

module anc_carriage_outer_tube_with_holders(){
	difference(){
		union(){
			anc_carriage_outer_tube();
			for(a = [0, 180])
				rotate([0, a, -90]) translate([anc_outer_rod_radius+anc_bearing_7x3x2_outer_radius, 0.5*anc_bearing_7x3x2_width+anc_bearing_7x3x2_air, 0]) rotate([-90, 0, 0]) anc_carriage_bearing_holder();
		}
		cylinder(h = 2*anc_bearing_7x3x2_outer_radius*anc_epsilon, r = anc_outer_rod_radius+anc_carriage_tube_border_offset, center = true);
		for(a = [0, 180])
			rotate([0, a, -90]) translate([anc_outer_rod_radius+anc_bearing_7x3x2_outer_radius, 0.5*anc_bearing_7x3x2_width-(anc_epsilon-1), 0]) rotate([-90, 0, 0]) anc_carriage_bearing_holder_holes();
	}
}

module anc_carriage_half(){
	difference(){
		union(){
			translate([anc_rods_distance, 0, 0]) anc_carriage_inner_tube_with_holders();
			anc_carriage_outer_tube_with_holders();
		}
		translate([25, 50, 0]) cube([100, 100, 100], center = true);
	}
}

module anc_carriage(){
	anc_carriage_half();
}

//anc_carriage_rods();
//anc_carriage_bearings();
//anc_carriage_spheres();
anc_carriage();
