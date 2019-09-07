include <../../settings.scad>;
use <../../utilities/cylinders.scad>;
use <../../connectors/notched_circle/male.scad>;
use <../../connectors/notched_circle/female.scad>;
include <measurements.scad>;

module hero_dualie_fore_skew() {
  // The connector to the glow.
  rotate([180, 0, 0]) {
    connectors_notched_circle_male(
      hero_dualie_fore_glow_skew_connector_diameter,
      hero_dualie_fore_glow_skew_connector_length,
      hero_dualie_fore_glow_skew_connector_notches
    );
  };
    
  // The skewed section.
  multmatrix([
    [1, 0, 0, 0],
    [0, 1, hero_dualie_fore_skew / hero_dualie_fore_skew_length, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1]
  ]) {
    cylinder(
      d1 = hero_dualie_fore_skew_diameter,
      d2 = hero_dualie_fore_diameter,
      h = hero_dualie_fore_skew_length,
      $fn = cylinder_sides(hero_dualie_fore_diameter)
    );
  };
  
  difference() {
    union() {
      // The cylindrical shaft. 
      translate([
        0,
        hero_dualie_fore_skew,
        hero_dualie_fore_skew_length
      ]) {
        cylinder(
          d = hero_dualie_fore_diameter,
          h = hero_dualie_fore_length,
          $fn = cylinder_sides(hero_dualie_fore_diameter)
        );
      };
      
      // The rounding before the nut.
      translate([
        0,
        hero_dualie_fore_skew,
        hero_dualie_fore_skew_length + hero_dualie_fore_length
      ]) {
        intersection() {
          sphere(
            d = hero_dualie_fore_diameter,
            $fn = cylinder_sides(hero_dualie_fore_diameter)
          );
          translate([
            hero_dualie_fore_diameter / -2,
            hero_dualie_fore_diameter / -2,
            0
          ]) {
            cube([
              hero_dualie_fore_diameter,
              hero_dualie_fore_diameter,
              hero_dualie_fore_funnel_length
            ]);
          };
        };
      };
    };
    
    // The connector to the nut.
    translate([
      0,
      hero_dualie_fore_skew,
      hero_dualie_fore_skew_length + hero_dualie_fore_length + hero_dualie_fore_funnel_length + 0.001
    ]) {
      rotate([180, 0, 0]) {
        connectors_notched_circle_female(
          hero_dualie_fore_nut_connector_diameter,
          hero_dualie_fore_nut_connector_length + 0.001,
          hero_dualie_fore_nut_connector_notches
        );
      };
    };
  };
};
