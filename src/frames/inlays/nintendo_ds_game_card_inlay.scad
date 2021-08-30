use <../../utilities/dictionary_get.scad>;

function nintendo_ds_game_card_inlay_width_mm() = 34;
function nintendo_ds_game_card_inlay_height_mm() = 36;

/**
 * A Nintendo DS game card (without the Nintendo 3DS tab).  Compatible with the
 * SPR, CTR, FTR, TWL and UTL models (and the un-codenamed "New 3DS" range).
 * Likely compatible with the USG and NTR models.
 * @param An array representing a dictionary, containing:
 *        - origin
 *          - x_mm - The origin of the inlay on the X axis, in millimeters.
 *          - y_mm - The origin of the inlay on the Y axis, in millimeters.
 * @return An array describing the inlay.
 */
function nintendo_ds_game_card_inlay(settings) =
  let (origin = dictionary_get(settings, "origin"))
  let (origin_x_mm = dictionary_get(origin, "x_mm"))
  let (origin_y_mm = dictionary_get(origin, "y_mm"))
  [
    ["type", "nintendo_ds_game_card"],
    [
      "origin",
      [
        ["x_mm", origin_x_mm],
        ["y_mm", origin_y_mm],
      ],
    ],
  ];
