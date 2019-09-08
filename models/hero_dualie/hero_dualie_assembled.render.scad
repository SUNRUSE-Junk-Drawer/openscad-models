include <../settings.scad>;
use <barrel/shape.scad>;
use <muffler/shape.scad>;
use <muzzle/shape.scad>;
use <body/left.scad>;
use <body/right.scad>;
use <handle/shape.scad>;
use <fore/glow.scad>;
use <fore/skew.scad>;
use <fore/nut.scad>;
use <feed/shape.scad>;
use <safety/shape.scad>;
use <trigger/shape.scad>;
use <tube/nut.scad>;
use <tube/main.scad>;
include <barrel/measurements.scad>;
include <muffler/measurements.scad>;
include <muzzle/measurements.scad>;
include <body/measurements.scad>;
include <fore/measurements.scad>;
include <feed/measurements.scad>;
include <tube/measurements.scad>;

translate([
  hero_dualie_body_thickness / 2,
  hero_dualie_body_safety_x,
  hero_dualie_body_front_height / 2 - hero_dualie_body_safety_y
]) {
  rotate([90, hero_dualie_body_safety_angle, 90]) {
    hero_dualie_safety_shape();
  };
};

translate([
  0,
  hero_dualie_body_safety_x,
  hero_dualie_body_front_height / 2 - hero_dualie_body_safety_y
]) {
  rotate([90, 90 - hero_dualie_body_trigger_angle, -90]) {
    hero_dualie_trigger_shape();
  };
};

translate([
  0,
  0,
  -hero_dualie_body_front_height / 2
]) {
  hero_dualie_fore_glow();
  
  translate([
    0,
    hero_dualie_fore_x,
    -hero_dualie_fore_y
  ]) {
    rotate([180 + hero_dualie_fore_angle, 0, 0]) {
      hero_dualie_fore_skew();
        
      translate([
        0,
        hero_dualie_fore_skew,
        hero_dualie_fore_skew_length + hero_dualie_fore_length + hero_dualie_fore_funnel_length + hero_dualie_fore_nut_length
      ]) {
        rotate([0, 180, 270]) {
          hero_dualie_fore_nut();
        };
        rotate([90, 0, 270]) {
            hero_dualie_feed_shape();
        };
        translate([
          0,
          -hero_dualie_feed_x,
          hero_dualie_feed_y
        ]) {
          rotate([90, 90, 0]) {
            rotate([0, -hero_dualie_feed_angle, 0]) {
              hero_dualie_tube_nut();
              translate([0, 0, hero_dualie_tube_nut_length]) {
                rotate([0, 0, 90]) {
                  hero_dualie_tube_main();
                };
              };
            }
          };
        };
      };
    };
  };
};

translate([
  0,
  0,
  hero_dualie_body_front_height / 2
]) {
  rotate([-90, 0, 90]) {
    hero_dualie_body_left();
    hero_dualie_body_right();
  };
};

translate([
  0,
  hero_dualie_body_handle_x,
  -hero_dualie_body_handle_y - hero_dualie_body_handle_cap_height + hero_dualie_body_front_height / 2
]) {
    rotate([180, 0, 0]) {
        hero_dualie_handle_shape();
    };
};

rotate([90, 0, 0]) {
  translate([0, 0, -hero_dualie_barrel_connector_length]) {
    hero_dualie_barrel_shape();
  }

  translate([0, 0, hero_dualie_barrel_length]) {
    hero_dualie_muffler_shape();
  };

  translate([
    0,
    0,
    hero_dualie_barrel_length + hero_dualie_muffler_body_length + hero_dualie_muffler_transition_to_muzzle_length - hero_dualie_muzzle_connector_length
  ]) {
    hero_dualie_muzzle_shape();
  };
};
