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
