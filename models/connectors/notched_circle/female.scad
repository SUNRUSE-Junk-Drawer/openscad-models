include <../../settings.scad>;
include <constants.scad>;

// Renders the female counterpart of a circular connector with an orienting
// notch.  Place on the surface oriented so that Z- is the surface normal.
module connectors_notched_circle_female(
    // The outer diameter of the compatible male circle.
    diameter,
    // The length of the male compatible circle.
    length
) {
  union() {
    difference() {
      cylinder(
        d = diameter + tight_tolerance,
        h = length + tight_tolerance,
        $fn = cylinder_sides(diameter)
      );
      cylinder(
        d = diameter - connectors_notched_circle_thickness - tight_tolerance,
        h = length + tight_tolerance,
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
          d = connectors_notched_circle_notch_diameter + tight_tolerance,
          h = length + tight_tolerance,
          $fn = cylinder_sides(connectors_notched_circle_notch_diameter)
        );
      };
      cylinder(
        d = diameter + tight_tolerance,
        h = length + tight_tolerance,
        $fn = cylinder_sides(diameter)
      );
    };
  };
};

difference() {
  cube([10, 10, 7]);

  translate([5, 5, 7.001]) {
    rotate([180, 0, 0]) {
      connectors_notched_circle_female(6, 5);
    }
  };
};
