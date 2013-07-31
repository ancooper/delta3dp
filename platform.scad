include <config.scad>
use <carriage.scad>

h=platform_thickness;

cutout = 12.5;
inset = 6;

module platform() {
  translate([0, 0, 4]) 
  difference() {
    union() {
      for (a = [0,120,240]) {
        rotate([0, 0, a]) {
		translate([0, -33, 0]) for(b = [-90, 90])
          	rotate([0, 0, b]) anc_carriage_sphere_holder();
          // Close little triangle holes.
          *translate([0, 31, 0]) cylinder(r=5, h=h, center=true);
          // Holder for adjustable bottom endstops.
          *translate([0, 45, 0]) cylinder(r=5, h=h, center=true);
        }
      }
      cylinder(r=30, h=8*anc_epsilon, center=true);
    }
    cylinder(r=20, h=8*anc_epsilon, center=true);
    for (m = [-20, 20]) translate([0, 0, m]) cylinder(r=50*anc_epsilon, h=32, center=true);
    for (a = [60:60:360]) {
      rotate(a) {
        translate([0, -25, 0])
          cylinder(r=2.2, h=8*anc_epsilon, center=true, $fn=12);
        // Screw holes for adjustable bottom endstops.
        translate([0, 45, 0]) cylinder(r=1.5, h=8*anc_epsilon, center=true, $fn=12);
      }
    }
  }
}

platform();