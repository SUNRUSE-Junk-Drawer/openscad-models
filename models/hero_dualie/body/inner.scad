use <../../utilities/curves.scad>;
include <measurements.scad>;
use <outer.scad>;

module hero_dualie_body_inner() {
  // This is a very complex hack to perform an inset.

    // Turn it back inside out.
  difference() {
    translate([
      -hero_dualie_body_wall_thickness,
      -hero_dualie_body_wall_thickness
    ]) {
      square([
        hero_dualie_body_top_length + hero_dualie_body_tail_length + hero_dualie_body_wall_thickness * 2,
        hero_dualie_body_handle_y + hero_dualie_body_wall_thickness * 2,
      ]);
    };

    // Expand the outer (now inner) edge.
    minkowski() {
      circle(r = hero_dualie_body_wall_thickness);

      // Turn the outer edge inside out.
      difference() {
        translate([
          -hero_dualie_body_wall_thickness,
          -hero_dualie_body_wall_thickness
        ]) {
          square([
            hero_dualie_body_top_length + hero_dualie_body_tail_length + hero_dualie_body_wall_thickness * 2,
            hero_dualie_body_handle_y + hero_dualie_body_wall_thickness * 2,
          ]);
        };
        hero_dualie_body_outer();
      }
    };
  };
};
