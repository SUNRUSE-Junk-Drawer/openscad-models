include <../settings.scad>;
use <barrel/shape.scad>;
use <muffler/shape.scad>;
use <muzzle/shape.scad>;
use <body/left.scad>;
use <body/right.scad>;
use <handle/shape.scad>;
use <fore/glow.scad>;
include <barrel/measurements.scad>;
include <muffler/measurements.scad>;
include <muzzle/measurements.scad>;
include <body/measurements.scad>;
include <fore/measurements.scad>;

translate([
  0,
  0,
  -hero_dualie_body_front_height / 2
]) {
  hero_dualie_fore_glow();
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
