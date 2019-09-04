include <../../settings.scad>;
use <female.scad>;

difference() {
  cube([22, 22, 7]);

  translate([11, 11, 7.001]) {
    rotate([180, 0, 0]) {
      connectors_notched_circle_female(18, 5, 3);
    }
  };
};
