include <../../settings.scad>;
include <constants.scad>;

// Renders the male counterpart of a circular connector with an orienting notch.
// Place on the surface oriented so that Z+ is the surface normal.
module connectors_notched_circle_male(
    // The outer diameter of the male circle.
    diameter,
    // The length of the male circle.
    length
) {
  union() {
    difference() {
      cylinder(
        d = diameter,
        h = length,
        $fn = cylinder_sides(diameter)
      );
      cylinder(
        d = diameter - connectors_notched_circle_thickness,
        h = length,
        $fn = cylinder_sides(diameter)
      );
    };
    intersection() {
      translate([
        0,
        diameter / 2 - connectors_notched_circle_thickness / 2,
        0
      ]) {
        cylinder(
          d = connectors_notched_circle_notch_diameter,
          h = length,
          $fn = cylinder_sides(connectors_notched_circle_notch_diameter)
        );
      };
      cylinder(
        d = diameter,
        h = length,
        $fn = cylinder_sides(diameter)
      );
    };
  };
};
