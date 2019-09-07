include <../../settings.scad>;
use <../../utilities/cylinders.scad>;
use <grip.scad>;
include <measurements.scad>;
include <../body/measurements.scad>;
include <../barrel/measurements.scad>;
use <../../connectors/notched_circle/female.scad>;

module hero_dualie_handle_shape() {
    difference() {
        hero_dualie_handle_grip();

        // Connector to body.
        rotate([0, 0, -90]) {
            connectors_notched_circle_female(
                hero_dualie_body_handle_connector_diameter,
                hero_dualie_body_handle_connector_length,
                hero_dualie_body_handle_connector_notches
            );
        };

        // A tube for the wire.
        cylinder(
          d = hero_dualie_barrel_led_hole_diameter,
          h = hero_dualie_handle_merge_back_y + hero_dualie_handle_height,
          $fn = cylinder_sides(5 + loose_tolerance)
        );
    };
};
