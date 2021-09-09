use <../../utilities/dictionary_get.scad>;

/**
 * Given an inlay, determines the depth (in millimeters) to which the inlay
 * should protrude from the frame.
 * @param inlay The inlay to measure.
 * @return      The depth (in millimeters) to which the inlay should protrude
 *              from the frame.
 */
function inlay_depth_mm(inlay) = dictionary_get
(
  [
    ["nintendo_3ds_game_card", 3.8],
    ["nintendo_ds_game_card", 3.8],
    ["nintendo_game_boy_cartridge", 8.5],
  ],
  dictionary_get(inlay, "type")
);
