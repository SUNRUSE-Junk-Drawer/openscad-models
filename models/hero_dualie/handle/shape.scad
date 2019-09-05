include <../../settings.scad>;
use <grip.scad>;
include <../body/measurements.scad>;
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
    };
};
