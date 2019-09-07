use <../utilities/cylinders.scad>

// Generates a nut exterior along Z+, including rounded vertices.
module components_nut(
  // The diameter of the nut, measures between opposing vertices.
  vertex_diameter,
  // The length of the nut along Z+.
  length,
  // The number of sides on the nut.
  sides,
  // The radiusing to apply horizontally.
  horizontal_radiusing,
  // The radiusing to apply vertically.
  vertical_radiusing
) {
  intersection() {
    cylinder(
      d = vertex_diameter,
      h = length,
      $fn = sides
    );
    translate([0, 0, length / 2]) {
      scale([
        vertex_diameter * horizontal_radiusing,
        vertex_diameter * horizontal_radiusing,
        length * vertical_radiusing
      ]) {
        sphere(1, $fn = cylinder_sides(norm([vertex_diameter, length]) * 2));
      };
    };
  };
};
