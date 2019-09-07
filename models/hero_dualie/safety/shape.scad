include <../../settings.scad>;
use <../../utilities/cylinders.scad>;
use <../../utilities/curves.scad>;
include <measurements.scad>;
use <../../connectors/notched_circle/male.scad>;

module hero_dualie_safety_shape() {
  // The connector to the body.
  rotate([180, 0, 0]) {
    connectors_notched_circle_male(
      hero_dualie_safety_connector_diameter,
      hero_dualie_safety_connector_length,
      hero_dualie_safety_connector_notches
    );
  };

  // The shaft.
  cylinder(
    d = hero_dualie_safety_shaft_diameter,
    h = hero_dualie_safety_shaft_length,
    $fn = cylinder_sides(hero_dualie_safety_shaft_diameter)
  );

  // The horn works by intersecting a top and side profile.
  intersection() {
    // The top profile.
    linear_extrude(hero_dualie_safety_shaft_length) {
      top = utilities_curves_exponential(
        [0, hero_dualie_safety_horn_base_a],
        [hero_dualie_safety_horn_length, hero_dualie_safety_horn_tip_a],
        [1, 2]
      );

      bottom = utilities_curves_exponential(
        [hero_dualie_safety_horn_length, hero_dualie_safety_horn_tip_b],
        [0, hero_dualie_safety_horn_base_b],
        [2, 1]
      );

      points = concat(top, bottom);

      polygon(points);
    };

    min_y = min(
      hero_dualie_safety_horn_base_a,
      hero_dualie_safety_horn_base_b,
      hero_dualie_safety_horn_tip_a,
      hero_dualie_safety_horn_tip_b
    );
    max_y = max(
      hero_dualie_safety_horn_base_a,
      hero_dualie_safety_horn_base_b,
      hero_dualie_safety_horn_tip_a,
      hero_dualie_safety_horn_tip_b
    );
    translate([0, max_y, 0]) {
      rotate([90, 0, 0]) {
        linear_extrude(max_y - min_y) {
          // The side profile.
          top = [
            [0, hero_dualie_safety_shaft_length],
            [hero_dualie_safety_horn_length, hero_dualie_safety_shaft_length]
          ];

          bottom = utilities_curves_exponential(
            [
              hero_dualie_safety_horn_length,
              hero_dualie_safety_shaft_length - hero_dualie_safety_horn_thickness
            ],
            [0, 0],
            [1, 2]
          );

          points = concat(top, bottom);

          polygon(points);
        };
      };
    };
  };
};
