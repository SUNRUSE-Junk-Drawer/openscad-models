use <../../utilities/dictionary_get.scad>;

/**
 * A square border.
 * @param An array representing a dictionary, containing:
 *        - thickness_mm - The thickness of the frame in millimeters.
 * @return An array describing the border.
 */
function square_border(settings) =
  let (thickness_mm = dictionary_get(settings, "thickness_mm"))
  [
    ["type", "square"],
    ["thickness_mm", thickness_mm],
  ];
