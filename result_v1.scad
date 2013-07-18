// Ancooper delta 3D printer

include <config.scad>;
include <properties.scad>;
use <corner.scad>;
use <stepper_holder.scad>;
use <carriage.scad>;

// Result printer

layers = [0, anc_stepper_holder_height+anc_corner_height, anc_printer_height-anc_corner_height];

for(i=[0:2]) translate([0, 0, layers[i]+0.5*anc_corner_height+anc_printer_stand_height]) tricorner();

for(i=[0:2])	rotate([0, 0, 120*i]){
	translate([anc_printer_radious-anc_rods_distance, 0, 0.5*(anc_printer_height-(anc_stepper_holder_height+anc_corner_height))+anc_stepper_holder_height+anc_corner_height+anc_printer_stand_height]) innerrod();
	translate([anc_printer_radious, 0, 0.5*anc_printer_height+anc_printer_stand_height]) outerrod();
}

for(i=[0:2]) rotate([0, 0, 120*i]){
	rotate([0, 0, 180]) translate([-anc_printer_radious, 0, anc_printer_stand_height+anc_corner_height+0.5*anc_stepper_holder_height]) anc_stepper_holder_result();
}

module tricorner(){
	for(i=[0:2]) {
		rotate([0, 0, 180+120*i]) translate([-anc_printer_radious, 0, 0]) color(anc_corner_color) anc_corner();
		rotate([0, 0, 120*i]) link();
	}
}

for(i=[0:2]) rotate([0, 0, 180+120*i]) translate([-anc_printer_radious, 0, 360]) color(anc_corner_color){
	anc_carriage_rods();
	anc_carriage_bearings();
	anc_carriage_spheres();
	anc_carriage();
	rotate([180, 0, 0]) anc_carriage();
}

module link(){
	translate([anc_corner_link_offset-anc_printer_radious*sin(30)-anc_corner_outer_tube_radius, 0, 0]) rotate([0, 90, 90]) color(anc_printer_link_color) 
		cylinder(h = 2*((anc_printer_radious - anc_rods_distance)*cos(30)+anc_corner_loaded_border_width), r = anc_link_radius, center = true);
}

module innerrod(){
	color(anc_printer_link_color) cylinder(h = anc_printer_height-(anc_stepper_holder_height+anc_corner_height), r = anc_inner_rod_radius, center = true);
}

module outerrod(){
	color(anc_printer_link_color) cylinder(h = anc_printer_height, r = anc_outer_rod_radius, center = true);
}
