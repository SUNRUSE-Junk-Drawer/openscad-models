use <../../utilities/dictionary_get.scad>;

/**
 * A rounded flat border.
 * @param An array representing a dictionary, containing:
 *        - thickness_mm - The thickness of the frame in millimeters.
 *        - sides        - The number of sides per corner.
 * @return An array describing the border.
 */
function rounded_flat_border(settings) =
  let (thickness_mm = dictionary_get(settings, "thickness_mm"))
  let (sides = dictionary_get(settings, "sides"))
  [
    ["type", "rounded_flat"],
    ["thickness_mm", thickness_mm],
    ["sides", sides],
  ];
