use <fretboard.scad>;
use <fret.scad>;
use <../../utilities/linear_interpolate.scad>;

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
    z_mm_over_fretboard_radius_origin(fretboard_radius_mm, 0, body_thickness_mm, neck_width_mm / 2) - pow(sin(point_index * 180 / neck_sides), neck_shape) * neck_thickness_mm
  ]
];

/**
 * Interpolates between two values over over the neck.
 * @param scale_length_mm    The distance between the middle of the zero fret
 *                           and the middle of the bridge fret.
 * @param fret_count         The number of (non-zero or bridge) frets.
 * @param at_zero            The value
 * @param at_last_non_bridge The value at the last non-bridge fret (e.g. fret
 *                           24 when there are 24 frets).
 * @param y_mm               The position at which the value is being sampled.
 * @param shape              The shape of the interpolation, where:
 *                           - less than 1    = changes more quickly near the
 *                                              zero fret.
 *                           - equal to 1     = changes linearly.
 *                           - greater than 1 = changes more quickly near the
 *                                              body.
 * @return                   The interpolated value.
 */
function neck_interpolate(
  scale_length_mm,
  fret_count,
  at_zero,
  at_last_non_bridge,
  y_mm,
  shape
) = echo(y_mm - fret_y_mm(scale_length_mm, 0)) linear_interpolate(
  at_zero,
  at_last_non_bridge,
  pow(max(0, min(1, (fret_y_mm(scale_length_mm, 0) - y_mm) / (fret_y_mm(scale_length_mm, 0) - fret_y_mm(scale_length_mm, fret_count)))), shape)
);
