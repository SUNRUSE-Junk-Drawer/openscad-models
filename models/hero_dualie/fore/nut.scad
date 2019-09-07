include <../../settings.scad>;
use <../../utilities/cylinders.scad>;
use <../../components/nut.scad>;
use <../../connectors/notched_circle/male.scad>;
include <measurements.scad>;

module hero_dualie_fore_nut() {
  components_nut(
    hero_dualie_fore_nut_diameter,
    hero_dualie_fore_nut_length,
    hero_dualie_fore_nut_sides,
    hero_dualie_fore_nut_horizontal_radiusing,
    hero_dualie_fore_nut_vertical_radiusing
  );

  // The connector to the skew.
  translate([
    0,
    0,
    hero_dualie_fore_nut_length
  ]) {
    rotate([0, 0, 90]) {
      connectors_notched_circle_male(
        hero_dualie_fore_nut_connector_diameter,
        hero_dualie_fore_nut_connector_length,
        hero_dualie_fore_nut_connector_notches
      );
    };
  };
};
