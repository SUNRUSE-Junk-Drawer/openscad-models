include <../../settings.scad>;
use <../../utilities/cylinders.scad>;
use <../../connectors/notched_circle/male.scad>;
use <../../connectors/notched_circle/female.scad>;
use <../body/outer.scad>;
include <../body/measurements.scad>;
include <../barrel/measurements.scad>;
include <measurements.scad>;

module hero_dualie_fore_glow() {
  difference() {
    union() {
      difference() {
        union() {
          rotate([0, 90, 0]) {
            linear_extrude(hero_dualie_fore_glow_wedge_thickness, center = true) {
              difference() {
                // The wedge's exterior.
                polygon([
                  [hero_dualie_fore_glow_wedge_a_x, hero_dualie_fore_glow_wedge_a_y],
                  [hero_dualie_fore_glow_wedge_b_x, hero_dualie_fore_glow_wedge_b_y],
                  [hero_dualie_fore_glow_wedge_c_x, hero_dualie_fore_glow_wedge_c_y],
                  [hero_dualie_fore_glow_wedge_d_x, hero_dualie_fore_glow_wedge_d_y],
                ]);

                // Cut the body's arc out for a good fit.
                translate([-hero_dualie_body_front_height, 0]) {
                  scale([-1, 1]) {
                    rotate(90) {
                      hero_dualie_body_outer();
                    };
                  };
                };

                // Some holes for LED light to shine through.
                intersection() {
                  x_min = min(
                    hero_dualie_fore_glow_wedge_cutout_a_x,
                    hero_dualie_fore_glow_wedge_cutout_b_x,
                    hero_dualie_fore_glow_wedge_cutout_c_x,
                    hero_dualie_fore_glow_wedge_cutout_d_x
                  );
                  y_min = min(
                    hero_dualie_fore_glow_wedge_cutout_a_y,
                    hero_dualie_fore_glow_wedge_cutout_b_y,
                    hero_dualie_fore_glow_wedge_cutout_c_y,
                    hero_dualie_fore_glow_wedge_cutout_d_y
                  );
                  x_max = max(
                    hero_dualie_fore_glow_wedge_cutout_a_x,
                    hero_dualie_fore_glow_wedge_cutout_b_x,
                    hero_dualie_fore_glow_wedge_cutout_c_x,
                    hero_dualie_fore_glow_wedge_cutout_d_x
                  );
                  y_max = max(
                    hero_dualie_fore_glow_wedge_cutout_a_y,
                    hero_dualie_fore_glow_wedge_cutout_b_y,
                    hero_dualie_fore_glow_wedge_cutout_c_y,
                    hero_dualie_fore_glow_wedge_cutout_d_y
                  );
                  for (x = [x_min:3:x_max]) {
                    for (y = [y_min:3:y_max]) {
                      translate([x, y]) {
                        square([1, 1], center = true);
                      };
                    }
                  }
                  polygon([
                    [hero_dualie_fore_glow_wedge_cutout_a_x, hero_dualie_fore_glow_wedge_cutout_a_y],
                    [hero_dualie_fore_glow_wedge_cutout_b_x, hero_dualie_fore_glow_wedge_cutout_b_y],
                    [hero_dualie_fore_glow_wedge_cutout_c_x, hero_dualie_fore_glow_wedge_cutout_c_y],
                    [hero_dualie_fore_glow_wedge_cutout_d_x, hero_dualie_fore_glow_wedge_cutout_d_y],
                  ]);
                };
              };
            };
          };

          translate([
            0,
            hero_dualie_fore_glow_pillar_x,
            hero_dualie_fore_glow_pillar_y
          ]) {
            // The connector to the body.
            rotate([
              -hero_dualie_fore_glow_pillar_angle,
              0,
              0
            ]) {
              connectors_notched_circle_male(hero_dualie_fore_glow_pillar_diameter, hero_dualie_fore_glow_pillar_connector_length, hero_dualie_fore_glow_pillar_connector_notches);
            };

            rotate([
              180 - hero_dualie_fore_glow_pillar_angle,
              0,
              0
            ]) {
              difference() {
                // The pillar's exterior.
                cylinder(
                  d = hero_dualie_fore_glow_pillar_diameter,
                  h = hero_dualie_fore_glow_pillar_length,
                  $fn = cylinder_sides(hero_dualie_fore_glow_pillar_diameter)
                );

                // Some holes for LED light to shine through.
                translate([0, 0, hero_dualie_fore_glow_pillar_floor_ceiling_thickness]) {
                  cylinder_perforations(
                    hero_dualie_fore_glow_pillar_diameter,
                    hero_dualie_fore_glow_pillar_length - hero_dualie_fore_glow_pillar_floor_ceiling_thickness * 2,
                    1,
                    3
                  );
                };
              };
            };
          };

          translate([
            0,
            hero_dualie_fore_x,
            -hero_dualie_fore_y
          ]) {
            rotate([
              hero_dualie_fore_angle,
              0,
              0
            ]) {
              difference() {
                // The ring.
                cylinder(
                  d = hero_dualie_fore_glow_ring_diameter,
                  h = hero_dualie_fore_glow_ring_length,
                  $fn = cylinder_sides(hero_dualie_fore_glow_ring_diameter)
                );

                // Some holes for LED light to shine through.
                translate([0, 0, hero_dualie_fore_glow_ring_floor_ceiling_thickness]) {
                  cylinder_perforations(
                    hero_dualie_fore_glow_ring_diameter,
                    hero_dualie_fore_glow_ring_length - hero_dualie_fore_glow_ring_floor_ceiling_thickness * 2,
                    1,
                    3
                  );
                };
              };
            };
          };
        };

        // The wedge's interior.
        rotate([0, 90, 0]) {
          linear_extrude(hero_dualie_fore_glow_wedge_thickness - hero_dualie_fore_glow_wedge_wall_thickness * 2, center = true) {
            polygon([
              [hero_dualie_fore_glow_wedge_cutout_a_x, hero_dualie_fore_glow_wedge_cutout_a_y],
              [hero_dualie_fore_glow_wedge_cutout_b_x, hero_dualie_fore_glow_wedge_cutout_b_y],
              [hero_dualie_fore_glow_wedge_cutout_c_x, hero_dualie_fore_glow_wedge_cutout_c_y],
              [hero_dualie_fore_glow_wedge_cutout_d_x, hero_dualie_fore_glow_wedge_cutout_d_y],
            ]);
          };
        };

        translate([
          0,
          hero_dualie_fore_glow_pillar_x,
          hero_dualie_fore_glow_pillar_y
        ]) {
          rotate([
            180 - hero_dualie_fore_glow_pillar_angle,
            0,
            0
          ]) {
            translate([
              0,
              0,
              hero_dualie_fore_glow_pillar_floor_ceiling_thickness
            ]) {
              // The pillar's interior.
              cylinder(
                d = hero_dualie_fore_glow_pillar_diameter - hero_dualie_fore_glow_pillar_wall_thickness * 2,
                h = hero_dualie_fore_glow_pillar_length - hero_dualie_fore_glow_pillar_floor_ceiling_thickness,
                $fn = cylinder_sides(hero_dualie_fore_glow_pillar_diameter)
              );

              // A hole for the LED.
              rotate([180, 0, 0]) {
                translate([0, 0, -0.001]) {
                  cylinder(
                    d = hero_dualie_barrel_led_hole_diameter,
                    h = hero_dualie_fore_glow_pillar_floor_ceiling_thickness + 0.002,
                    $fn = cylinder_sides(hero_dualie_barrel_led_hole_diameter)
                  );
                };
              };
            };
          };
        };

        // The ring's interior.
        translate([
          0,
          hero_dualie_fore_x,
          -hero_dualie_fore_y
        ]) {
          rotate([
            hero_dualie_fore_angle,
            0,
            0
          ]) {
            translate([0, 0, hero_dualie_fore_glow_ring_floor_ceiling_thickness]) {
              cylinder(
                d = hero_dualie_fore_glow_ring_diameter - hero_dualie_fore_glow_ring_wall_thickness * 2,
                h = hero_dualie_fore_glow_ring_length - hero_dualie_fore_glow_ring_floor_ceiling_thickness * 2,
                $fn = cylinder_sides(hero_dualie_fore_glow_ring_diameter)
              );
            };
          };
        };
      };

      // The block from which the skew connector is cut.
      translate([
        0,
        hero_dualie_fore_x,
        -hero_dualie_fore_y
      ]) {
        rotate([
          hero_dualie_fore_angle,
          0,
          0
        ]) {
          cylinder(
            d = hero_dualie_fore_glow_skew_connector_diameter + hero_dualie_fore_glow_ring_wall_thickness * 2,
            h = hero_dualie_fore_glow_skew_connector_length + tight_tolerance + hero_dualie_fore_glow_ring_floor_ceiling_thickness,
            $fn = cylinder_sides(hero_dualie_fore_glow_skew_connector_diameter)
          );
        };
      };
    };

    // The skew connector.
    translate([
      0,
      hero_dualie_fore_x,
      -hero_dualie_fore_y
    ]) {
      rotate([
        hero_dualie_fore_angle,
        0,
        0
      ]) {
        connectors_notched_circle_female(
          hero_dualie_fore_glow_skew_connector_diameter,
          hero_dualie_fore_glow_skew_connector_length,
          hero_dualie_fore_glow_skew_connector_notches
        );
      };
    };
  };
};
