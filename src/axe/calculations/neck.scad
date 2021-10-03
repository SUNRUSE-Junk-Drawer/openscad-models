use <fretboard.scad>;

/**
 * Generates an array of 2D points representing a cross section of the neck,
 * running clockwise.
 * @param fretboard_radius_mm The radius of the fretboard, in millimeters.
 * @param body_thickness_mm   The thickness of the body, in millimeters.
 * @param neck_sides          The number of sides of the neck.
 * @param neck_width_mm       The width of the neck at the cross section.
 * @param neck_thickness_mm   The thickness of the neck at the cross section.
 * @param neck_shape          The shape of the neck at the cross section, where:
 *                            - less than 1    = U-shaped.
 *                            - equal to 1     = semi-circular.
 *                            - greater than 1 = V-shaped.
 * @return                    An array of 2D points representing a cross section
 *                            of the neck, running clockwise.
 */
function neck_cross_section(
  fretboard_radius_mm,
  body_thickness_mm,
  neck_sides,
  neck_width_mm,
  neck_thickness_mm,
  neck_shape
) = [
  for (point_index = [0 : neck_sides]) [
    cos(point_index * 180 / neck_sides) * neck_width_mm / 2,
    y_mm_over_fretboard_radius_origin(fretboard_radius_mm, 0, body_thickness_mm, neck_width_mm / 2) - pow(sin(point_index * 180 / neck_sides), neck_shape) * neck_thickness_mm
  ]
];
