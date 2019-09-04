use <../../utilities/curves.scad>;
include <measurements.scad>;

module hero_dualie_body_outer() {
  top_edge = utilities_curves_exponential(
    [0, 0],
    [hero_dualie_body_top_length, hero_dualie_body_top_height],
    [1, 2]
  );

  tail = [
    [hero_dualie_body_top_length + hero_dualie_body_tail_length, hero_dualie_body_top_height],
    [hero_dualie_body_top_length + hero_dualie_body_tail_length, hero_dualie_body_top_height + hero_dualie_body_wall_thickness],
    [hero_dualie_body_top_length, hero_dualie_body_top_height + hero_dualie_body_wall_thickness]
  ];

  handle = [
    [hero_dualie_body_handle_x + hero_dualie_body_handle_length / 2, hero_dualie_body_handle_y]
  ];

  bottom_edge = utilities_curves_exponential(
    [hero_dualie_body_handle_x - hero_dualie_body_handle_length / 2, hero_dualie_body_handle_y],
    [0, hero_dualie_body_front_height],
    [1, 1 / 1.5]
  );

  outer_loop = concat(top_edge, tail, handle, bottom_edge);

  polygon(outer_loop);
};
