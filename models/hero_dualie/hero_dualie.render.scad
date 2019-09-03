include <../settings.scad>;
use <barrel/shape.scad>;
use <muffler/shape.scad>;
use <muzzle/shape.scad>;

rotate([90, 0, 0]) {
  hero_dualie_barrel_shape();

  translate([0, 0, 50]) {
    hero_dualie_muffler_shape();
  };

  translate([0, 0, 140]) {
    hero_dualie_muzzle_shape();
  };
};
