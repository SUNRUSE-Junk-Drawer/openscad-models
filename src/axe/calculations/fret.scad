/**
 * Calculates an array of the distances between the middle of the zero fret and
   the middles of every other non-bridge fret.
 * @param scale_length_mm The distance between the middle of the zero fret and
 *                        the middle of the bridge fret.
 * @param fret_count      The number of (non-zero or bridge) frets.
 * @return                An array of the distances between the middle of the
 *                        zero fret and the middles of every other non-bridge
 *                        fret.
 */
function fret_positions(scale_length_mm, fret_count) = [for (fret_index = [1 : fret_count]) scale_length_mm - (scale_length_mm / pow(2, fret_index / 12))];
