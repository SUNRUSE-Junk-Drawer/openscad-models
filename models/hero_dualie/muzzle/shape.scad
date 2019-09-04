use <../../utilities/cylinders.scad>;
include <measurements.scad>;
use <../../connectors/notched_circle/female.scad>;

module hero_dualie_muzzle_shape() {
  difference() {
    // The body.
    cylinder_sequence(
      hero_dualie_muzzle_start_diameter,
      [
        [
          hero_dualie_muzzle_connector_length,
          hero_dualie_muzzle_start_diameter
        ],
        [
          hero_dualie_muzzle_length,
          hero_dualie_muzzle_end_diameter
        ]
      ],
      cylinder_sides(hero_dualie_muzzle_start_diameter)
    );

    // The hole in the end.
    cylinder(
      d = hero_dualie_muzzle_hole_diameter,
      h = hero_dualie_muzzle_connector_length + hero_dualie_muzzle_length,
      $fn = cylinder_sides(hero_dualie_muzzle_hole_diameter)
    );

    // The connector to the muffler.
    connectors_notched_circle_female(
      hero_dualie_muzzle_connector_diameter,
      hero_dualie_muzzle_connector_length,
      hero_dualie_muzzle_connector_notches
    );
  };
};
