include <../../measurements/truss_rod.scad>;

translate([
  0,
  truss_rod_length_mm / -2,
  0,
]) {
  rotate([-90, 0, 0]) {
    cylinder(
      d = truss_rod_diameter_mm,
      h = truss_rod_length_mm,
      $fn = truss_rod_sides
    );
  };
}
