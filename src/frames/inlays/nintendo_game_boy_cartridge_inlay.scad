use <../../utilities/dictionary_get.scad>;

width_mm = 57.5;
height_mm = 65.5;
depth_mm = 7.35;

bevel_length_mm = 1.75;
bevel_retainer_width_mm = 4;
bevel_retainer_length_mm = 35;

slot_retainer_height_mm = 1;
slot_retainer_depth_mm = 4;

top_retainer_width_mm = 35;
top_retainer_height_mm = 1;
top_retainer_depth_mm = 2;

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
  translate([
    width_mm / -2 - bevel_retainer_width_mm,
    height_mm / -2 - slot_retainer_height_mm,
    0,
  ]) {
    cube([
      width_mm + bevel_retainer_width_mm * 2,
      slot_retainer_height_mm,
      slot_retainer_depth_mm,
    ]);
  };

  translate([0, height_mm / -2, 0]) {
    rotate([90, 0, 180]) {
      linear_extrude(bevel_retainer_length_mm) {
        polygon([
          [width_mm / -2, 0],
          [
            width_mm / -2,
            depth_mm - sqrt(pow(bevel_length_mm, 2) / 2),
          ],
          [
            width_mm / -2 + sqrt(pow(bevel_length_mm, 2) / 2),
            depth_mm,
          ],
          [
            width_mm / -2 + sqrt(pow(bevel_length_mm, 2) / 2) - bevel_retainer_width_mm,
            depth_mm,
          ],
          [
            width_mm / -2 - bevel_retainer_width_mm,
            depth_mm - sqrt(pow(bevel_length_mm, 2) / 2),
          ],
          [
            width_mm / -2 - bevel_retainer_width_mm,
            0,
          ],
        ]);

        polygon([
          [width_mm / 2, 0],
          [
            width_mm / 2,
            depth_mm - sqrt(pow(bevel_length_mm, 2) / 2),
          ],
          [
            width_mm / 2 - sqrt(pow(bevel_length_mm, 2) / 2),
            depth_mm,
          ],
          [
            width_mm / 2 - sqrt(pow(bevel_length_mm, 2) / 2) + bevel_retainer_width_mm,
            depth_mm,
          ],
          [
            width_mm / 2 + bevel_retainer_width_mm,
            depth_mm - sqrt(pow(bevel_length_mm, 2) / 2),
          ],
          [
            width_mm / 2 + bevel_retainer_width_mm,
            0,
          ],
        ]);
      };
    };
  };

  translate([
    top_retainer_width_mm / -2,
    height_mm / 2,
    0,
  ]) {
    cube([
      top_retainer_width_mm,
      top_retainer_height_mm,
      top_retainer_depth_mm,
    ]);
  };
};
