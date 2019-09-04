use <../../utilities/cylinders.scad>;
include <measurements.scad>;
use <inner.scad>;

module hero_dualie_body_indent() {
  difference() {
    intersection() {
      hero_dualie_body_inner();
      square([
        hero_dualie_body_handle_x + hero_dualie_body_handle_length / 2 - hero_dualie_body_wall_thickness / 2,
        hero_dualie_body_handle_y
      ]);
    };
    translate([
      hero_dualie_body_safety_x,
      hero_dualie_body_safety_y
    ]) {
      circle(
        d = hero_dualie_body_safety_surround_diameter,
        $fn = cylinder_sides(hero_dualie_body_safety_surround_diameter)
      );
    };
  };
};
