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
function string_x_mm(
  y_mm,
  string_index,
  string_count,
  scale_length_mm,
  string_spread_zero_mm,
  string_spread_bridge_mm,
) = linear_interpolate(
  string_spread_zero_mm,
  string_spread_bridge_mm,
  min(1, max(0, (y_mm - fret_y_mm(scale_length_mm, 0)) / (fret_bridge_y_mm(scale_length_mm) - fret_y_mm(scale_length_mm, 0))))
) * ((string_index / (string_count - 1)) - 0.5);

/**
 * @param y_mm                           The position at which the string is
 *                                       being sampled on the Y axis, in
 *                                       millimeters.
 * @param string_index                   The string number, where 0 is the
                                         leftmost.
 * @param string_count                   The number of strings.
 * @param scale_length_mm                The distance between the middle of the
 *                                       zero fret and the middle of the bridge
 *                                       fret, in millimeters.
 * @param string_spread_zero_mm          The distance between the highest and
 *                                       lowest strings at the zero fret, in
 *                                       millimeters.
 * @param string_spread_bridge_mm        The distance between the highest and
 *                                       lowest strings at the bridge fret, in
 *                                       millimeters.
 * @param fretboard_radius_mm            The radius of the fretboard, in
 *                                       millimeters.
 * @param fret_zero_and_bridge_offset_mm The vertical offset of the bridge and
 *                                       nut frets relative to all other frets
 *                                       (the string height/action), in
 *                                       millimeters.
 * @param fret_height_mm                 The height of frets (how far they stick
 *                                       out of the fretboard), in millimeters.
 * @param string_diameter_mm             The diameter of a string, in
 *                                       millimeters.
 * @param body_thickness_mm              The thickness of the body, in
 *                                       millimeters.
 * @return                               The position of the string on the Z
 *                                       axis in millimeters.
 */
function string_z_mm(
  y_mm,
  string_index,
  string_count,
  scale_length_mm,
  string_spread_zero_mm,
  string_spread_bridge_mm,
  fretboard_radius_mm,
  fret_zero_and_bridge_offset_mm,
  fret_height_mm,
  string_diameter_mm,
  body_thickness_mm,
) = z_mm_over_fretboard_radius_origin(
  fretboard_radius_mm,
  fret_zero_and_bridge_offset_mm + fret_height_mm + string_diameter_mm / 2,
  body_thickness_mm,
  string_x_mm(
    y_mm,
    string_index,
    string_count,
    scale_length_mm,
    string_spread_zero_mm,
    string_spread_bridge_mm
  )
);
