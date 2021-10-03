include <../../measurements/body.scad>;
include <../../measurements/fret.scad>;
include <../../measurements/truss_rod.scad>;
use <../../calculations/truss_rod.scad>;

translate([
  0,
  truss_rod_length_mm / -2,
  truss_rod_z(
    truss_rod_cutout_diameter_mm,
    body_thickness_mm,
    fret_tang_height_mm
  ),
]) {
  rotate([-90, 0, 0]) {
    cylinder(
      d = truss_rod_diameter_mm,
      h = truss_rod_length_mm,
      $fn = truss_rod_sides
    );
  };
}
