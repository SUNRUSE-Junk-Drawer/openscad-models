use <distance_3d.scad>;

/**
 * Draws a loft between two arrays of points in 3D space.
 * @param from An array, where items are arrays of 3 numbers representing the
 *             location of a point on the X, Y and Z axes.  These points form an
 *             edge loop from which to loft.
 * @param to   An array, where items are arrays of 3 numbers representing the
 *             location of a point on the X, Y and Z axes.  These points form an
 *             edge loop to which to loft.
 */
module loft(from, to) {
  polyhedron(
    points = concat(from, to),
    faces = concat(
      [
        [
          for (index = [0 : len(from) - 1]) index
        ],
        [
          for (index = [0 : len(from) - 1]) len(from) * 2 - 1 - index
        ]
      ],
      [
        for (index = [0 : len(from) - 1]) [
          (index + 1) % len(from),
          index,
          index + len(from),
          (index + 1) % len(from) + len(from),
        ]
      ]
    )
  );
};
