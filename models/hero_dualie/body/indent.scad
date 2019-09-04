include <measurements.scad>;
use <inner.scad>;

module hero_dualie_body_indent() {
  intersection() {
    hero_dualie_body_inner();
    square([
      hero_dualie_body_handle_x + hero_dualie_body_handle_length / 2 - hero_dualie_body_wall_thickness / 2,
      hero_dualie_body_handle_y
    ]);
  };
};
