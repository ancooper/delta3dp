// Ancooper delta 3D printer

include <config.scad>;
include <properties.scad>;
use <corner.scad>;

// Result


module anc_couple_corner(){
	translate([0, -19, 0]) rotate([0, 0, 30]) anc_corner_v2();
	translate([0, 19, 0]) rotate([0, 0, -30]) anc_corner_v2();
	translate([-32, 0, 0])rotate([90, 0, 0]) cylinder(h = 60, r = 4, center = true);
}

module anc_couple_rod(){
	translate([-120-12*cos(30), 25, 0]) cylinder(h = 500, r = 5);
	translate([-120-12*cos(30), -25, 0]) cylinder(h = 500, r = 5);
}

module anc_layer(){
	translate([-120, 0, 0]) anc_couple_corner();
	rotate([0, 0, 120]) translate([-120, 0, 0]) anc_couple_corner();
	rotate([0, 0, -120]) translate([-120, 0, 0]) anc_couple_corner();

	translate([125*cos(30), 0, 0]) rotate([90, 0, 0]) cylinder(h = 210, r = 4, center = true);
	rotate([0, 0, 120]) translate([125*cos(30), 0, 0]) rotate([90, 0, 0]) cylinder(h = 210, r = 4, center = true);
	rotate([0, 0, -120]) translate([125*cos(30), 0, 0]) rotate([90, 0, 0]) cylinder(h = 210, r = 4, center = true);
}


layers = [10, 70, 470];
for(i=[0:2]) translate([0, 0, layers[i]]) anc_layer();

anc_couple_rod();
rotate([0, 0, 120]) anc_couple_rod();
rotate([0, 0, -120]) anc_couple_rod();