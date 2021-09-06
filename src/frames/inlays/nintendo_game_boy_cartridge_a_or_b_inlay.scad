use <../../utilities/dictionary_get.scad>;

width_mm = 58;
height_mm = 66;

notch_width_mm = 5.175;
notch_height_mm = 3;

retainer_width_mm = 51;
retainer_depth_offset_mm = 1.5;
retainer_height_mm = 3;

/**
 * A Nintendo Game Boy cartridge which has a notch in the top right corner,
 * compatible with the DMG, MGB, CGB, AGB and AGS models.
 * @param An array representing a dictionary, containing:
 *        - origin
 *          - x_mm - The origin of the inlay on the X axis, in millimeters.
 *          - y_mm - The origin of the inlay on the Y axis, in millimeters.
 * @return An array describing the inlay.
 */
function nintendo_game_boy_cartridge_a_or_b_inlay(settings) =
  let (origin = dictionary_get(settings, "origin"))
  let (origin_x_mm = dictionary_get(origin, "x_mm"))
  let (origin_y_mm = dictionary_get(origin, "y_mm"))
  [
    ["type", "nintendo_game_boy_cartridge_a_or_b"],
    [
      "origin",
      [
        ["x_mm", origin_x_mm],
        ["y_mm", origin_y_mm],
      ],
    ],
  ];

module nintendo_game_boy_cartridge_a_or_b_inlay(settings, inlay, embed_depth_mm) {
  difference() {
    translate([0, 0, -embed_depth_mm]) {
      linear_extrude(embed_depth_mm) {
        difference() {
          translate([width_mm / -2, height_mm / -2]) {
            square([width_mm, height_mm]);
          };

          translate([
            width_mm / 2 - notch_width_mm,
            height_mm / 2 - notch_height_mm,
          ]) {
            square([notch_width_mm, notch_height_mm]);
          };
        };
      };
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
