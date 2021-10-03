use <../../utilities/linear_interpolate.scad>;
use <fret.scad>;
use <fretboard.scad>;

/**
  * Calculates the position of a string on the X axis in millimeters.
  * @param y_mm                    The position at which the string is being
  *                                sampled on the Y axis, in millimeters.
  * @param string_index            The string number, where 0 is the leftmost.
  * @param string_count            The number of strings.
  * @param scale_length_mm         The distance between the middle of the zero
  *                                fret and the middle of the bridge fret, in
  *                                millimeters.
  * @param string_spread_zero_mm   The distance between the highest and lowest
  *                                strings at the zero fret, in millimeters.
  * @param string_spread_bridge_mm The distance between the highest and lowest
  *                                strings at the bridge fret, in millimeters.
  * @return                        The position of the string on the X axis in
  *                                millimeters.
  */
function truss_rod_z(
  truss_rod_cutout_diameter_mm,
  body_thickness_mm,
  fret_tang_height_mm,
) = body_thickness_mm - fret_tang_height_mm - truss_rod_cutout_diameter_mm / 2;
