// When true, lower resolution primitives will be used.
draft = false;

$fs = draft ? 1 : 0.5;

// The amount of space left between parts which must fit together tightly.
tight_tolerance = 0.6;

// The amount of space left between parts which must fit together loosely.
loose_tolerance = 1;

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
    5
  )
);
