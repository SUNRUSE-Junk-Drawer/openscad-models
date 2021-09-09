use <../../utilities/dictionary_get.scad>;

width_mm = 58;
height_mm = 66;

retainer_width_mm = 51;
retainer_depth_offset_mm = 1.5;
retainer_height_mm = 3;

/**
 * A Nintendo Game Boy cartridge, compatible with the DMG, MGB, CGB, AGB and AGS
 * models.
 * @param An array representing a dictionary, containing:
 *        - origin
 *          - x_mm - The origin of the inlay on the X axis, in millimeters.
 *          - y_mm - The origin of the inlay on the Y axis, in millimeters.
 * @return An array describing the inlay.
 */
function nintendo_game_boy_cartridge_inlay(settings) =
  let (origin = dictionary_get(settings, "origin"))
  let (origin_x_mm = dictionary_get(origin, "x_mm"))
  let (origin_y_mm = dictionary_get(origin, "y_mm"))
  [
    ["type", "nintendo_game_boy_cartridge"],
    [
      "origin",
      [
        ["x_mm", origin_x_mm],
        ["y_mm", origin_y_mm],
      ],
    ],
  ];

module nintendo_game_boy_cartridge_inlay(settings, inlay, embed_depth_mm) {
  difference() {
    translate([
      width_mm / -2,
      height_mm / -2,
      -embed_depth_mm,
    ]) {
      cube([
        width_mm,
        height_mm,
        embed_depth_mm,
      ]);
    };

    translate([
      retainer_width_mm / -2,
      height_mm / -2,
      retainer_depth_offset_mm - embed_depth_mm,
    ]) {
      rotate([0, 90, 0]) {
        linear_extrude(retainer_width_mm) {
          polygon([
            [0, 0],
            [retainer_depth_offset_mm - embed_depth_mm, retainer_height_mm],
            [retainer_depth_offset_mm - embed_depth_mm, 0],
          ]);
        };
      };
    };
  };
};
