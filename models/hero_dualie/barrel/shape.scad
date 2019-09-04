include <../../settings.scad>;
use <../../utilities/cylinders.scad>;
include <measurements.scad>;
use <../../connectors/notched_circle/male.scad>;
use <../../connectors/notched_circle/female.scad>;

module hero_dualie_barrel_shape() {
  difference() {
    // The outer cylinder.
    cylinder(
      d = hero_dualie_barrel_diameter,
      h = hero_dualie_barrel_connector_length + hero_dualie_barrel_length,
      $fn = cylinder_sides(hero_dualie_barrel_diameter)
    );

    // The connector to the body.
    connectors_notched_circle_female(
      hero_dualie_barrel_connector_diameter,
      hero_dualie_barrel_connector_length,
      hero_dualie_barrel_connector_notches
    );

    // The chamber in which the LED sits.
    translate([
      0,
      0,
      hero_dualie_barrel_connector_length + hero_dualie_barrel_floor_ceiling_thickness
    ]) {
      cylinder(
        d = hero_dualie_barrel_diameter - hero_dualie_barrel_wall_thickness * 2,
        h = hero_dualie_barrel_length - hero_dualie_barrel_floor_ceiling_thickness * 2,
        $fn = cylinder_sides(hero_dualie_barrel_diameter)
      );
    };

    // Some holes for LED light to shine through.
    translate([0, 0, hero_dualie_barrel_connector_length]) {
      cylinder_perforations(
        hero_dualie_barrel_diameter,
        hero_dualie_barrel_length,
        1,
        3
      );
    };

    // A hole for the LED.
    cylinder(
      d = hero_dualie_barrel_led_hole_diameter,
      h = hero_dualie_barrel_connector_length + hero_dualie_barrel_floor_ceiling_thickness,
      $fn = cylinder_sides(5 + loose_tolerance)
    );
  };

  // The connector to the muffler.
  translate([
    0,
    0,
    hero_dualie_barrel_connector_length + hero_dualie_barrel_length
  ]) {
    connectors_notched_circle_male(
      hero_dualie_barrel_connector_diameter,
      hero_dualie_barrel_connector_length,
      hero_dualie_barrel_connector_notches
    );
  };

  // Narrow columns surrounding the LED.
  // These both guide the LED and hold the roof up during printing.
  for (angle = [0:90:270]) {
    rotate([0, 0, angle]) {
      translate([
        0,
        (hero_dualie_barrel_led_hole_diameter + hero_dualie_barrel_led_rail_diameter) / 2,
        hero_dualie_barrel_connector_length + hero_dualie_barrel_floor_ceiling_thickness
      ]) {
        cylinder(
          d = hero_dualie_barrel_led_rail_diameter,
          h = hero_dualie_barrel_length - hero_dualie_barrel_floor_ceiling_thickness * 2,
          $fn = cylinder_sides(hero_dualie_barrel_led_rail_diameter)
        );
      };
    };
  };
};
