use <../../utilities/dictionary_get.scad>;

width_mm = 34;
height_mm = 35.5;
depth_mm = 3.8;

side_retainer_height_mm = 10;
side_retainer_width_mm = 2;
side_retainer_lip_width_mm = 1;
side_retainer_lip_depth_mm = 1.2;

bottom_retainer_height_mm = 1;

top_retainer_width_mm = 15;
top_retainer_height_mm = 2;
top_retainer_depth_mm = 1.5;

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

module nintendo_ds_cartridge_inlay(settings, inlay, embed_depth_mm) {
  difference() {
    translate([
      (side_retainer_width_mm + width_mm + side_retainer_width_mm) / -2,
      height_mm / -2 - bottom_retainer_height_mm,
      0,
    ]) {
      cube([
        side_retainer_width_mm + width_mm + side_retainer_width_mm,
        bottom_retainer_height_mm + side_retainer_height_mm,
        depth_mm + side_retainer_lip_depth_mm,
      ]);
    };

    translate([
      width_mm / -2,
      height_mm / -2,
      0,
    ]) {
      cube([
        width_mm,
        bottom_retainer_height_mm + side_retainer_height_mm,
        depth_mm,
      ]);
    };

    translate([
      width_mm / -2 + side_retainer_lip_width_mm,
      height_mm / -2,
      depth_mm,
    ]) {
      cube([
        width_mm - side_retainer_lip_width_mm * 2,
        bottom_retainer_height_mm + side_retainer_height_mm,
        side_retainer_lip_depth_mm,
      ]);
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
