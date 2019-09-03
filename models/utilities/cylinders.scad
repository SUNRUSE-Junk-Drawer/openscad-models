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
