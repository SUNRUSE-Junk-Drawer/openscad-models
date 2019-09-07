include <../../settings.scad>;
use <../../utilities/cylinders.scad>;
use <../../utilities/lofts.scad>;
use <../../utilities/curves.scad>;
include <measurements.scad>;

module hero_dualie_feed_shape() {
  sides = cylinder_sides(hero_dualie_feed_diameter);
  ring = [
    for (vertex = [0:sides - 1])
      let (angle = vertex * 360 / sides)
        [cos(angle), sin(angle)] * hero_dualie_feed_diameter / 2
  ];

  start_ring = [ for (vertex = ring) [
    vertex[0],
    -hero_dualie_feed_connector_depth,
    vertex[1]
  ] ];

  joining_rings = [ for (point = utilities_curves_exponential(
    [0, 0, 0],
    [hero_dualie_feed_x, hero_dualie_feed_y, 90 - hero_dualie_feed_angle],
    [2, 1, 1]
  )) [ for (vertex = ring) [
    point[0] + cos(point[2]) * vertex[0],
    point[1] - sin(point[2]) * vertex[0],
    vertex[1]
  ] ] ];

  end_ring = [ for (vertex = ring) [
    hero_dualie_feed_x + sin(hero_dualie_feed_angle) * vertex[0] + cos(hero_dualie_feed_angle) * hero_dualie_feed_connector_depth,
    hero_dualie_feed_y - cos(hero_dualie_feed_angle) * vertex[0] + sin(hero_dualie_feed_angle) * hero_dualie_feed_connector_depth,
    vertex[1]
  ] ];

  rings = concat([start_ring], joining_rings, [end_ring]);

  utilities_lofts_generate(rings);
};
