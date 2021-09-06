use <../../utilities/dictionary_get.scad>;

/**
 * Given an inlay, determines the depth (in millimeters) to which the inlay
 * should protrude from the frame.
 * @param inlay The inlay to measure.
 * @return      The depth (in millimeters) to which the inlay should protrude
 *              from the frame.
 */
function inlay_protrusion_depth_mm(inlay) = dictionary_get
(
  [
    ["nintendo_3ds_game_card", 1.3],
    ["nintendo_ds_game_card", 1.3],
    ["nintendo_game_boy_cartridge_a_or_b", 4],
    ["nintendo_game_boy_cartridge_c", 5],
  ],
  dictionary_get(inlay, "type")
);
