include <../../settings.scad>;
use <../../utilities/cylinders.scad>;
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
      // The outer circle.
      cylinder_sequence(
        diameter + loose_tolerance,
        [
          [
            connectors_notched_circle_loose_length,
            diameter + loose_tolerance
          ],
          [
            connectors_notched_circle_loose_to_tight_length,
            diameter + tight_tolerance
          ],
          [
            length + tight_tolerance - connectors_notched_circle_loose_length - connectors_notched_circle_loose_to_tight_length,
            diameter + tight_tolerance
          ],
        ],
        cylinder_sides(diameter)
      );

      // The inner circle.
      cylinder_sequence(
        diameter - connectors_notched_circle_thickness - loose_tolerance,
        [
          [
            connectors_notched_circle_loose_length,
            diameter - connectors_notched_circle_thickness - loose_tolerance
          ],
          [
            connectors_notched_circle_loose_to_tight_length,
            diameter - connectors_notched_circle_thickness - tight_tolerance
          ],
          [
            length + tight_tolerance - connectors_notched_circle_loose_length - connectors_notched_circle_loose_to_tight_length,
            diameter - connectors_notched_circle_thickness - tight_tolerance
          ],
        ],
        cylinder_sides(diameter)
      );
    };

    intersection() {
      // The notch.
      translate([
        0,
        diameter / 2 - connectors_notched_circle_thickness / 2,
        0
      ]) {
        cylinder_sequence(
          connectors_notched_circle_notch_diameter + loose_tolerance,
          [
            [
              connectors_notched_circle_loose_length,
              connectors_notched_circle_notch_diameter + loose_tolerance
            ],
            [
              connectors_notched_circle_loose_to_tight_length,
              connectors_notched_circle_notch_diameter + tight_tolerance
            ],
            [
              length + tight_tolerance - connectors_notched_circle_loose_length - connectors_notched_circle_loose_to_tight_length,
              connectors_notched_circle_notch_diameter + tight_tolerance
            ],
          ],
          cylinder_sides(connectors_notched_circle_notch_diameter)
        );
      };

      // Ensure that the notch does not escape the outer circle.
      cylinder_sequence(
        diameter + loose_tolerance,
        [
          [
            connectors_notched_circle_loose_length,
            diameter + loose_tolerance
          ],
          [
            connectors_notched_circle_loose_to_tight_length,
            diameter + tight_tolerance
          ],
          [
            length + tight_tolerance - connectors_notched_circle_loose_length - connectors_notched_circle_loose_to_tight_length,
            diameter + tight_tolerance
          ],
        ],
        cylinder_sides(diameter)
      );
    };
  };
};
