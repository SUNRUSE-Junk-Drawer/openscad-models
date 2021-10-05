use <truss_rod.scad>;
use <../../utilities/linear_interpolate.scad>;

/**
 * Calculates the angle of a point on the X axis around the origin of the
 * fretboard radius.
 * @param fretboard_radius_mm The radius of the fretboard, in millimeters.
 * @param x_mm                The point to sample on the X axis, in millimeters.
 * @return                    The angle of the given point on the X axis around
 *                            the origin of the fretboard radius.
 */
function degrees_around_fretboard_radius_origin(fretboard_radius_mm, x_mm) = asin(x_mm / fretboard_radius_mm);

/**
 * Calculates the Z position of a point on the X axis around the origin of the
 * fretboard radius, in millimeters.
 * @param fretboard_radius_mm The radius of the fretboard, in millimeters.
 * @param radius_offset_mm    An offset above the fretboard, in millimeters.
 * @param body_thickness_mm   The thickness of the body, in millimeters.
 * @param x_mm                The point to sample on the X axis, in millimeters.
 * @return                    The angle of the given point on the X axis around
 *                            the origin of the fretboard radius.
 */
function z_mm_over_fretboard_radius_origin(fretboard_radius_mm, radius_offset_mm, body_thickness_mm, x_mm) = cos(degrees_around_fretboard_radius_origin(fretboard_radius_mm, x_mm)) * (fretboard_radius_mm + radius_offset_mm) + body_thickness_mm - fretboard_radius_mm;

/**
 * Generates an array of 2D points representing a cross section of the
 * fretboard on a fret, running clockwise.
 * @param fretboard_radius_mm The radius of the fretboard, in millimeters.
 * @param fretboard_sides     The number of sides of the fretboard.
 * @param neck_width_mm       The width of the neck at the cross section.
 * @param body_thickness_mm   The thickness of the body, in millimeters.
 * @param include_corners     When true, the first and final vertices (common
 *                            with the neck cross section) will be included.
 *                            They will otherwise be omitted.
 * @return                    An array of 2D points representing a cross section
 *                            of the fretboard on a fret, running clockwise.
 */
function fretboard_cross_section(
  fretboard_radius_mm,
  fretboard_sides,
  neck_width_mm,
  body_thickness_mm,
  include_corners
) = [
  for (point_index = [
    include_corners ? 0 : 1 : fretboard_sides - (include_corners ? 0 : 1)
  ]) let (x_mm = ((point_index / fretboard_sides) - 0.5) * neck_width_mm) [
    x_mm,
    z_mm_over_fretboard_radius_origin(fretboard_radius_mm, 0, body_thickness_mm, x_mm),
  ]
];

/**
 * Generates an array of 2D points representing a cross section of the
 * fretboard between frets, running clockwise.
 * @param fretboard_radius_mm           The radius of the fretboard, in
 *                                      millimeters.
 * @param fretboard_sides               The number of sides of the fretboard.
 * @param neck_width_mm                 The width of the neck at the cross
 *                                      section.
 * @param body_thickness_mm             The thickness of the body, in
 *                                      millimeters.
 * @param include_corners               When true, the first and final vertices
 *                                      (common with the neck cross section)
 *                                      will be included.  They will otherwise
 *                                      be omitted.
 * @param fretboard_cutout_margin_sides The number of sides either side of
 *                                      fretboard cutouts.
 * @param fretboard_cutout_shape        The shape of fretboard cutouts, where:
 *                                      - less than 1    = U-shaped.
 *                                      - equal to 1     = semi-circular.
 *                                      - greater than 1 = V-shaped.
 * @return                              An array of 2D points representing a
 *                                      cross section of the fretboard between
 *                                      frets, running clockwise.
 */
function fretboard_segment_cross_section(
  fretboard_radius_mm,
  fretboard_sides,
  neck_width_mm,
  body_thickness_mm,
  include_corners,
  fretboard_cutout_margin_sides,
  fretboard_cutout_shape,
  truss_rod_cutout_diameter_mm,
  fret_tang_height_mm,
) = [
  for (point_index = [
    include_corners ? 0 : 1 : fretboard_sides - (include_corners ? 0 : 1)
  ]) let (x_mm = ((point_index / fretboard_sides) - 0.5) * neck_width_mm) [
    x_mm,
    point_index > fretboard_cutout_margin_sides && point_index < fretboard_sides - fretboard_cutout_margin_sides
      ? linear_interpolate(
        z_mm_over_fretboard_radius_origin(
          fretboard_radius_mm,
          0,
          body_thickness_mm,
          x_mm
        ),
        truss_rod_z_mm(
          truss_rod_cutout_diameter_mm,
          body_thickness_mm,
          fret_tang_height_mm
        ),
        pow(
          sin(180 * (point_index - fretboard_cutout_margin_sides) / (fretboard_sides - fretboard_cutout_margin_sides * 2)),
          fretboard_cutout_shape
        )
      )
      : z_mm_over_fretboard_radius_origin(fretboard_radius_mm, 0, body_thickness_mm, x_mm),
  ]
];
