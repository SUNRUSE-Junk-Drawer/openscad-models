use <math.scad>;

// Approximates a curve by interpolating between two coordinates with a
// different rate of acceleration on each axis.
function utilities_curves_exponential(
  // The coordinate to interpolate from.
  from,
  // The coordinate to interpolate to.
  to,
  // The exponent on each axis, where:
  // - 0...1 starts fast then decelerates.
  // - 1 is linear.
  // - 1...infinity starts slow then accelerates.
  exponents
) = [
  for (progress = [0:utilities_curves_approximate_segments(from, to)]) [
    for (axis = [0:len(from) - 1])
      linear_interpolate(
        from[axis],
        to[axis],
        pow(
          progress / utilities_curves_approximate_segments(from, to),
          exponents[axis]
        )
      )
  ]
];

// Attempts to guess how many segments should be present on a curve.
function utilities_curves_approximate_segments(
  // The start of the curve.
  from,
  // The end of the curve.
  to
) = max(1, round(norm(to - from) / $fs) - 1);
