include <../../settings.scad>;
use <../../utilities/cylinders.scad>;
use <../../components/nut.scad>;
use <../../connectors/notched_circle/male.scad>;
use <../../connectors/notched_circle/female.scad>;
include <measurements.scad>;
include <../feed/measurements.scad>;

module hero_dualie_tube_main() {
  difference() {
    // The "funnel" to the feed.
    intersection() {
      translate([
        0,
        0,
        hero_dualie_tube_main_funnel_truncate
      ]) {
        scale([
          1,
          1,
          hero_dualie_tube_main_funnel_length / hero_dualie_tube_main_diameter
        ]) {
          sphere(
            d = hero_dualie_tube_main_diameter,
            $fn = cylinder_sides(hero_dualie_tube_main_diameter)
          );
        };
      };
      translate([
        hero_dualie_tube_main_diameter / -2,
        hero_dualie_tube_main_diameter / -2,
        0
      ]) {
        cube([
          hero_dualie_tube_main_diameter,
          hero_dualie_tube_main_diameter,
          hero_dualie_tube_main_funnel_truncate
        ]);
      };
    };

    // The connector to the feed.
    rotate([0, 0, 180]) {
      connectors_notched_circle_female(
        hero_dualie_tube_nut_connector_diameter,
        hero_dualie_tube_nut_connector_length,
        hero_dualie_tube_nut_connector_notches
      );
    };
  };

  // The main body of the tube.
  translate([
    0,
    0,
    hero_dualie_tube_main_funnel_truncate
  ]) {
    cylinder(
      d = hero_dualie_tube_main_diameter,
      h = hero_dualie_tube_main_length,
      $fn = cylinder_sides(hero_dualie_tube_main_diameter)
    );
  };

  // The connector to the hopper nut.
  translate([
    0,
    0,
    hero_dualie_tube_main_funnel_truncate + hero_dualie_tube_main_length
  ]) {
    rotate([0, 0, 180]) {
      connectors_notched_circle_male(
        hero_dualie_tube_hopper_connector_diameter,
        hero_dualie_tube_hopper_connector_length,
        hero_dualie_tube_hopper_connector_notches
      );
    };
  };
};
