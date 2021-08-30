use <../../utilities/dictionary_get.scad>;

/**
 * A Nintendo 3DS game card.  Compatible with the SPR, CTR and FTR models (and
 * the un-codenamed "New 3DS" range).
 * @param An array representing a dictionary, containing:
 *        - origin
 *          - x_mm - The origin of the inlay on the X axis, in millimeters.
 *          - y_mm - The origin of the inlay on the Y axis, in millimeters.
 * @return An array describing the inlay.
 */
function nintendo_3ds_game_card_inlay(settings) =
  let (origin = dictionary_get(settings, "origin"))
  let (origin_x_mm = dictionary_get(origin, "x_mm"))
  let (origin_y_mm = dictionary_get(origin, "y_mm"))
  [
    ["type", "nintendo_3ds_game_card"],
    [
      "origin",
      [
        ["x_mm", origin_x_mm],
        ["y_mm", origin_y_mm],
      ],
    ],
  ];
