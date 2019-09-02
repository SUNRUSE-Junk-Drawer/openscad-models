include <../../settings.scad>;
use <female.scad>;

difference() {
  cube([10, 10, 7]);

  translate([5, 5, 7.001]) {
    rotate([180, 0, 0]) {
      connectors_notched_circle_female(6, 5);
    }
  };
};
