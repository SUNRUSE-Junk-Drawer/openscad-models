include <../../settings.scad>;
include <unhalved.scad>;

module hero_dualie_body_left() {
  intersection() {
    hero_dualie_body_unhalved();
    cube([
      hero_dualie_body_top_length + hero_dualie_body_tail_length,
      hero_dualie_body_handle_y + hero_dualie_body_handle_cap_height + hero_dualie_body_handle_connector_length,
      hero_dualie_body_handle_cap_diameter / 2
    ]);
  };
};
