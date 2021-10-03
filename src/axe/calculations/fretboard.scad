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
 * Calculates the Y position of a point on the X axis around the origin of the
 * fretboard radius.
 * @param fretboard_radius_mm The radius of the fretboard, in millimeters.
 * @param radius_offset_mm    An offset above the fretboard, in millimeters.
 * @param body_thickness_mm   The thickness of the body, in millimeters.
 * @param x_mm                The point to sample on the X axis, in millimeters.
 * @return                    The angle of the given point on the X axis around
 *                            the origin of the fretboard radius.
 */
function y_mm_over_fretboard_radius_origin(fretboard_radius_mm, radius_offset_mm, body_thickness_mm, x_mm) = cos(degrees_around_fretboard_radius_origin(fretboard_radius_mm, x_mm)) * (fretboard_radius_mm + radius_offset_mm) + body_thickness_mm - fretboard_radius_mm;
