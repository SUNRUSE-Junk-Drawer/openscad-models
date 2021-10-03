/**
 * Calculates the distance between two points in 3D space, in millimeters.
 * @param from_mm     An array containing the X, Y and Z of the first point to
 *                    measure, in millimeters.
 * @param to_mm       An array containing the X, Y and Z of the second point to
 *                    measure, in millimeters.
 * @return            The
 */
function distance_3d(from_mm, to_mm) =
  let(difference_mm = to_mm - from_mm)
  sqrt(pow(difference_mm[0], 2) + pow(difference_mm[1], 2) + pow(difference_mm[2], 2));
