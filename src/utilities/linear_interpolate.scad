/**
 * Linearly interpolates between two values, extrapolating if out of range.
 * @param from  The value to interpolate from.
 * @param to    The value to interpolate to.
 * @param alpha The value to interpolate by, where:
 *              - less than 0                 = extrapolate beyond the "from"
 *                                              value.
 *              - 0                           = the "from" value.
 *              - greater than 0, less than 1 = interpolate between the "from"
 *                                              and "to" values.
 *              - 1                           = the "to" value.
 *              - greater than 1              = extrapolate beyond the "to"
 *                                              value.
 * @return      A linear interpolation between the two values, extrapolating if
 *              out of range.
 */
function linear_interpolate(from, to, alpha) = from + (to - from) * alpha;
