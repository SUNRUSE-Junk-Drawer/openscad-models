include <measurements.scad>;
use <inner.scad>;

module hero_dualie_body_cutout() {
  intersection() {
    hero_dualie_body_inner();
    translate([
      hero_dualie_body_handle_x + hero_dualie_body_handle_length / 2 + hero_dualie_body_wall_thickness / 2,
      0
    ]) {
      square([
        hero_dualie_body_top_length,
        hero_dualie_body_handle_y
      ]);
    };
  };
};
