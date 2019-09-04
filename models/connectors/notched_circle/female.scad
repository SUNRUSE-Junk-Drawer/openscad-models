include <../../settings.scad>;
use <../../utilities/cylinders.scad>;
include <constants.scad>;

// Renders the female counterpart of a circular connector with a number of
// orienting notches.  Place on the surface oriented so that Z- is the surface
// normal.
module connectors_notched_circle_female(
    // The outer diameter of the compatible male circle.
    diameter,
    // The length of the male compatible circle.
    length,
    // The number of notches, spaced evenly.
    notches
) {
  outer_circle_diameter_loose = diameter + loose_tolerance;
  outer_circle_diameter_tight = diameter + tight_tolerance;
  inner_circle_diameter_loose = diameter - connectors_notched_circle_thickness - loose_tolerance;
  inner_circle_diameter_tight = diameter - connectors_notched_circle_thickness - tight_tolerance;
  notch_diameter_loose = connectors_notched_circle_notch_diameter + loose_tolerance;
  notch_diameter_tight = connectors_notched_circle_notch_diameter + tight_tolerance;
  final_circle_length = length + tight_tolerance - connectors_notched_circle_loose_length - connectors_notched_circle_loose_to_tight_length;
  union() {
    difference() {
      // The outer circle.
      cylinder_sequence(
        outer_circle_diameter_loose,
        [
          [
            connectors_notched_circle_loose_length,
            outer_circle_diameter_loose
          ],
          [
            connectors_notched_circle_loose_to_tight_length,
            outer_circle_diameter_tight
          ],
          [
            final_circle_length,
            outer_circle_diameter_tight
          ],
        ],
        cylinder_sides(diameter)
      );

      // The inner circle.
      cylinder_sequence(
        inner_circle_diameter_loose,
        [
          [
            connectors_notched_circle_loose_length,
            inner_circle_diameter_loose
          ],
          [
            connectors_notched_circle_loose_to_tight_length,
            inner_circle_diameter_tight
          ],
          [
            final_circle_length,
            inner_circle_diameter_tight
          ],
        ],
        cylinder_sides(diameter)
      );
    };

    intersection() {
      // The notch.
      for (notch = [0:notches - 1]) {
        rotate([0, 0, notch * 360 / notches]) {
          translate([
            0,
            diameter / 2 - connectors_notched_circle_thickness / 2,
            0
          ]) {
            cylinder_sequence(
              notch_diameter_loose,
              [
                [
                  connectors_notched_circle_loose_length,
                  notch_diameter_loose
                ],
                [
                  connectors_notched_circle_loose_to_tight_length,
                  notch_diameter_tight
                ],
                [
                  final_circle_length,
                  notch_diameter_tight
                ],
              ],
              cylinder_sides(connectors_notched_circle_notch_diameter)
            );
          };
        };
      };

      // Ensure that the notch does not escape the outer circle.
      cylinder_sequence(
        outer_circle_diameter_loose,
        [
          [
            connectors_notched_circle_loose_length,
            outer_circle_diameter_loose
          ],
          [
            connectors_notched_circle_loose_to_tight_length,
            outer_circle_diameter_tight
          ],
          [
            final_circle_length,
            outer_circle_diameter_tight
          ],
        ],
        cylinder_sides(diameter)
      );
    };
  };
};
