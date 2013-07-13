// Ancooper delta 3D printer

include <config.scad>;

// Corner

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

module anc_corner(){
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

anc_corner();