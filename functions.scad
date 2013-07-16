// Ancooper delta 3D printer

include <config.scad>;

// Functions

module anc_rcube(v, r, center = false){
	if(center){
		minkowski(){
			cube([v[0]-2*r, v[1]-2*r, 0.5*v[2]], center = true);
			cylinder(h = 0.5*v[2], r = r, center = true);
		}
	}else{
		translate([r, r, 0]) minkowski(){
			cube([v[0]-2*r, v[1]-2*r, 0.5*v[2]]);
			cylinder(h = 0.5*v[2], r = r);
		}
	}
}

module anc_rail(length, width, hwidth, height, hheight){
	cyl_width = width-hwidth;
	cyl_height = 0.5*(0.5*height-hheight);
	cyl_radius = max(anc_epsilon, max(cyl_width, cyl_height));
	difference(){
		color(anc_co_color) cube([length, width, height], center = true);
		color(anc_co_color_diff) hull(){
			translate([0, 0.5*width, +cyl_height]) scale([1, cyl_width/cyl_radius, cyl_height/cyl_radius]) rotate([0, 90, 0]) cylinder(h = length*anc_epsilon, r = cyl_radius, center = true);
			translate([0, 0.5*width, -cyl_height]) scale([1, cyl_width/cyl_radius, cyl_height/cyl_radius]) rotate([0, 90, 0]) cylinder(h = length*anc_epsilon, r = cyl_radius, center = true);
		}
	}
}

// End

//anc_rcube([20, 20, 5], r = 5, center = true);
//anc_rail(25, 5, 2, 12, 1);