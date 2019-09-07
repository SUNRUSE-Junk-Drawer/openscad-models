include <../settings.scad>;
use <barrel/shape.scad>;
use <muffler/shape.scad>;
use <muzzle/shape.scad>;
use <body/left.scad>;
use <body/right.scad>;
use <handle/shape.scad>;
use <fore/glow.scad>;
use <safety/shape.scad>;
use <trigger/shape.scad>;

translate([60, 110, -60]) {
  rotate([90 , 0, 90]) {
    hero_dualie_safety_shape();
  };
};

translate([0, 90, -80]) {
  rotate([-90, 90, 90]) {
    hero_dualie_trigger_shape();
  };
};

translate([0, 20, -30]) {
    hero_dualie_fore_glow();
};

translate([-10, 30, 20]) {
    rotate([-90, 0, 90]) {
        hero_dualie_body_left();
    };
};

translate([10, 30, 20]) {
    rotate([-90, 0, 90]) {
        hero_dualie_body_right();
    };
};

translate([0, 130, -100]) {
    rotate([180, 0, 0]) {
        hero_dualie_handle_shape();
    };
};

rotate([90, 0, 0]) {
  hero_dualie_barrel_shape();

  translate([0, 0, 50]) {
    hero_dualie_muffler_shape();
  };

  translate([0, 0, 140]) {
    hero_dualie_muzzle_shape();
  };
};
