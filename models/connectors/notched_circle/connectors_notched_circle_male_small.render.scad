include <../../settings.scad>;
use <male.scad>;

cube([10, 10, 2]);
translate([5, 5, 2]) {
  connectors_notched_circle_male(6, 5, 1);
};
