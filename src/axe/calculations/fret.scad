use <fretboard.scad>;

/**
 * Calculates the position of the center of a fret on the Y axis.
 * @param scale_length_mm The distance between the middle of the zero fret and
 *                        the middle of the bridge fret.
 * @param fret_index      The number of the fret.
 * @return                The position of the center of the fret on the Y axis.
 */
function fret_y_mm(scale_length_mm, fret_index) = scale_length_mm / -2 + (scale_length_mm / pow(2, fret_index / 12));

/**
 * Calculates the position of the center of the bridge fret on the Y axis.
 * @param scale_length_mm The distance between the middle of the zero fret and
 *                        the middle of the bridge fret.
 * @return                The position of the center of the bridge fret on the Y
 *                        axis.
 */
function fret_bridge_y_mm(scale_length_mm) = scale_length_mm / -2;

/**
 * Generates an array of 2D points representing a cross section of the
 * fretboard on a fret, running clockwise.
 * @param fretboard_radius_mm        The radius of the fretboard, in
 *                                   millimeters.
 * @param fretboard_sides            The number of sides of the fretboard.
 * @param neck_width_mm              The width of the neck at the cross section.
 * @param body_thickness_mm          The thickness of the body, in millimeters.
 * @param fret_tang_cutout_height_mm The height of the cutout for a fret's tang,
 *                                   in millimeters.
 * @param fret_tang_cutout_margin_mm The amount of "trim" either side of a fret
 *                                   before the tang cutout, in millimeters.
 * @return                           An array of 2D points representing a cross
 *                                   section of the fretboard on a fret, running
 *                                   clockwise.
 */
function fret_cutout_cross_section(
  fretboard_radius_mm,
  fretboard_sides,
  neck_width_mm,
  body_thickness_mm,
  fret_tang_cutout_height_mm,
  fret_tang_cutout_margin_mm
) = concat(
  [
    for (point_index = [0 : fretboard_sides])
    let (x_mm = ((point_index / fretboard_sides) - 0.5) * (neck_width_mm - fret_tang_cutout_margin_mm * 2)) [
      x_mm,
      z_mm_over_fretboard_radius_origin(fretboard_radius_mm, fret_tang_cutout_height_mm, body_thickness_mm, x_mm),
    ]
  ],
  [
    for (point_index = [0 : fretboard_sides])
    let (x_mm = ((point_index / fretboard_sides) - 0.5) * -(neck_width_mm - fret_tang_cutout_margin_mm * 2)) [
      x_mm,
      z_mm_over_fretboard_radius_origin(fretboard_radius_mm, -fret_tang_cutout_height_mm, body_thickness_mm, x_mm),
    ]
  ]
);
