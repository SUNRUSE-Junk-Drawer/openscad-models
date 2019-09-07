include <../../settings.scad>;
use <../../utilities/curves.scad>;
include <measurements.scad>;

module hero_dualie_trigger_shape() {
  top = utilities_curves_exponential(
    [0, hero_dualie_trigger_base_a],
    [hero_dualie_trigger_length, hero_dualie_trigger_tip_a],
    [1, 2]
  );

  bottom = utilities_curves_exponential(
    [hero_dualie_trigger_length, hero_dualie_trigger_tip_b],
    [0, hero_dualie_trigger_base_b],
    [2, 1]
  );

  points = concat(top, bottom);

  linear_extrude(hero_dualie_trigger_thickness, center = true) {
    polygon(points);
  };
};
