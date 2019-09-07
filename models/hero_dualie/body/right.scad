include <../../settings.scad>;
include <unhalved.scad>;

module hero_dualie_body_right() {
  intersection() {
    hero_dualie_body_unhalved();
    translate([
      0,
      0,
      hero_dualie_body_handle_cap_diameter / -2
    ]) {
      cube([
        hero_dualie_body_top_length + hero_dualie_body_tail_length,
        hero_dualie_body_handle_y + hero_dualie_body_handle_cap_height + hero_dualie_body_handle_connector_length,
        hero_dualie_body_handle_cap_diameter / 2 - tight_tolerance / 2
      ]);
    };
  };
};
