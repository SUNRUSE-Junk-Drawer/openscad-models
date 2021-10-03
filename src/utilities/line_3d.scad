use <distance_3d.scad>;

/**
 * Draws a 3D line between two points.
 * @param from_mm     An array containing the X, Y and Z of the first point to
 *                    join, in millimeters.
 * @param to_mm       An array containing the X, Y and Z of the second point to
 *                    join, in millimeters.
 * @param diameter_mm The diameter of the 3D line, in millimeters.
 * @param sides       The number of sides of the 3D line.
 */
module line_3d(from_mm, to_mm, diameter_mm, sides) {
  difference_mm = to_mm - from_mm;
  distance_mm = distance_3d(from_mm, to_mm);

  rotate([
    0,
    acos(difference_mm[2] / distance_mm),
    atan2(difference_mm[1], difference_mm[0]),
  ]) {
    cylinder(d = diameter_mm, h = distance_mm, $fn = sides);
  };
};
