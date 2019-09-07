// Generates a solid shape from a sequence of rings of points.
module utilities_lofts_generate(
  // An array of arrays of vectors representing rings of points which will be
  // lofted together into a solid shape.
  // All must have the same number of points.
  rings
) {
  points = [for (ring = rings) for (vertex = ring) vertex];

  bottom_cap = [for (vertex = [0:len(rings[0]) - 3]) [
    0,
    vertex + 2,
    vertex + 1
  ]];

  sides_a = [for (ring = [0:len(rings) - 2]) for (vertex = [0:len(rings[0]) - 1]) [
    (ring + 1) * len(rings[0]) + (vertex % (len(rings[0]))),
    ring * len(rings[0]) + (vertex % (len(rings[0]))),
    (ring + 1) * len(rings[0]) + ((vertex + 1) % (len(rings[0])))
  ]];
  sides_b = [for (ring = [0:len(rings) - 2]) for (vertex = [0:len(rings[0]) - 1]) [
    ring * len(rings[0]) + ((vertex + 1) % (len(rings[0]))),
    (ring + 1) * len(rings[0]) + ((vertex + 1) % (len(rings[0]))),
    ring * len(rings[0]) + (vertex % (len(rings[0]))),
  ]];
  sides = concat(sides_a, sides_b);

  top_cap = [for (vertex = [0:len(rings[0]) - 3]) [
    (len(rings) - 1) * len(rings[0]),
    (len(rings) - 1) * len(rings[0]) + vertex + 1,
    (len(rings) - 1) * len(rings[0]) + vertex + 2
  ]];

  faces = concat(bottom_cap, sides, top_cap);

  polyhedron(
    points = points,
    faces = faces
  );
};

// Attempts to guess how many rings should be present on a procedural loft.
function utilities_lofts_approximate_segments(
  // The length of the loft.
  length
) = max(2, round(length / $fs) - 1);
