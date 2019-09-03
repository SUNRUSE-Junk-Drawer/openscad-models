// Calculates the $fn which should be used for a cylinder of a specific size.
function cylinder_sides(
  // The diameter of the cylinder.
  diameter
) = ceil(
  max(
    min(
      360 / $fa,
      diameter * PI / $fs
    ),
    8
  )
);

// Generates a grid of square perforations through a cylinder of a specific
// size.
module cylinder_perforations(
  // The diameter of the cylinder.
  diameter,
  // The height of the cylinder.
  length,
  // The size (width/height) of each perforation.
  perforation_size,
  // The target spacing between perforations.  This will be adjusted to fit
  // evenly on the cylinder.
  perforation_spacing
) {
  half_perimeter = diameter * PI / 2;
  angularPerforations = round(half_perimeter / perforation_spacing);
  zPerforations = round(half_perimeter / perforation_spacing);
  for (angle = [0:180 / angularPerforations:180]) {
    rotate([0, 0, angle]) {
      for (z = [perforation_spacing:perforation_spacing:length - perforation_spacing]) {
        translate([0, 0, z]) {
          cube([diameter, perforation_size, perforation_size], center = true);
        };
      }
    };
  };
};

// Generates a "pipe" which lofts a sequence of circles together.
module cylinder_sequence(
  // The diameter of the first circle.
  initial_diameter,
  // An array of arrays, where each child array is two numbers:
  // - The length of the segment along Z.
  // - The diameter of the end of the segment.
  length_diameter_pairs,
  // The number of sides of all circles drawn.
  sides,
  // Used for recursion; leave as default.
  i = 0
) {
  if (i < len(length_diameter_pairs)) {
    cylinder(
      d1 = initial_diameter,
      d2 = length_diameter_pairs[i][1],
      h = length_diameter_pairs[i][0],
      $fn = sides
    );
    translate([
      0,
      0,
      length_diameter_pairs[i][0]
    ]) {
      cylinder_sequence(
        length_diameter_pairs[i][1],
        length_diameter_pairs,
        sides,
        i + 1
      );
    };
  };
};
