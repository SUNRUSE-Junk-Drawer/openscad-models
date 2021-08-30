use <../../utilities/dictionary_get.scad>;

function nintendo_game_boy_cartridge_c_inlay_embed_width_mm() = 57.5;
function nintendo_game_boy_cartridge_c_inlay_embed_height_mm() = 66.25;

/**
 * A Nintendo Game Boy cartridge which does NOT have a notch in the top right
 * corner, compatible with the CGB, AGB and AGS models.
 * @param An array representing a dictionary, containing:
 *        - origin
 *          - x_mm - The origin of the inlay on the X axis, in millimeters.
 *          - y_mm - The origin of the inlay on the Y axis, in millimeters.
 * @return An array describing the inlay.
 */
function nintendo_game_boy_cartridge_c_inlay(settings) =
  let (origin = dictionary_get(settings, "origin"))
  let (origin_x_mm = dictionary_get(origin, "x_mm"))
  let (origin_y_mm = dictionary_get(origin, "y_mm"))
  [
    ["type", "nintendo_game_boy_cartridge_c"],
    [
      "origin",
      [
        ["x_mm", origin_x_mm],
        ["y_mm", origin_y_mm],
      ],
    ],
  ];

module nintendo_game_boy_cartridge_c_inlay(settings, inlay, embed_depth_mm) {
  translate([
    nintendo_game_boy_cartridge_c_inlay_embed_width_mm() / -2,
    nintendo_game_boy_cartridge_c_inlay_embed_height_mm() / -2,
    -embed_depth_mm,
  ]) {
    cube([
      nintendo_game_boy_cartridge_c_inlay_embed_width_mm(),
      nintendo_game_boy_cartridge_c_inlay_embed_height_mm(),
      embed_depth_mm,
    ]);
  };
};
