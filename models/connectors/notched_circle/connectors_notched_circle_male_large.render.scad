include <../../settings.scad>;
use <male.scad>;

cube([22, 22, 2]);
translate([11, 11, 2]) {
  connectors_notched_circle_male(18, 5);
};
