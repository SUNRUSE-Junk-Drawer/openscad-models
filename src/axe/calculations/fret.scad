/**
 * Calculates the position of the center of a fret on the Y axis.
 * @param scale_length_mm The distance between the middle of the zero fret and
 *                        the middle of the bridge fret.
 * @param fret_index      The number of the fret.
 * @return                The position of the center of the fret on the Y axis.
 */
function fret_y_mm(scale_length_mm, fret_index) = scale_length_mm / -2 + (scale_length_mm / pow(2, fret_index / 12));
