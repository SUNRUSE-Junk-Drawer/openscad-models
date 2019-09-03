include <../../settings.scad>;
use <../../utilities/math.scad>;
use <../../utilities/cylinders.scad>;
include <measurements.scad>;
include <../barrel/measurements.scad>;
include <../muzzle/measurements.scad>;
use <../../connectors/notched_circle/male.scad>;
use <../../connectors/notched_circle/female.scad>;

module hero_dualie_muffler_shape() {
  bottom_of_muzzle_recess = hero_dualie_muffler_body_length - hero_dualie_muffler_transition_to_muzzle_length;

  difference() {
    // The body.
    cylinder_sequence(
      hero_dualie_muffler_start_diameter,
      [
        [
          hero_dualie_muffler_body_length,
          hero_dualie_muffler_end_diameter
        ],
        [
          hero_dualie_muffler_transition_to_muzzle_length,
          hero_dualie_muzzle_start_diameter
        ]
      ],
      cylinder_sides(hero_dualie_muzzle_end_diameter)
    );

    // The connector to the barrel.
    connectors_notched_circle_female(
      hero_dualie_barrel_connector_diameter,
      hero_dualie_barrel_connector_length
    );

    // The recess for the muzzle.
    translate([
      0,
      0,
      bottom_of_muzzle_recess
    ]) {
      cylinder(
        d = hero_dualie_muzzle_start_diameter + loose_tolerance,
        h = hero_dualie_muzzle_connector_length,
        $fn = cylinder_sides(hero_dualie_muzzle_start_diameter)
      );
    };
  };

  // The connector to the muzzle.
  translate([
    0,
    0,
    bottom_of_muzzle_recess
  ]) {
    connectors_notched_circle_male(
      hero_dualie_muzzle_connector_diameter,
      hero_dualie_muzzle_connector_length
    );
  };
};
