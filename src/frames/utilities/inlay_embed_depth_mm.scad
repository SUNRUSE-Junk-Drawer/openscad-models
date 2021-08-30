use <../../utilities/dictionary_get.scad>;

/**
 * Given an inlay, determines the depth (in millimeters) to which the inlay
 * should embed into the frame.
 * @param inlay The inlay to measure.
 * @return      The depth (in millimeters) to which the inlay should embed into
 *              the frame.
 */
function inlay_embed_depth_mm(inlay) = dictionary_get
(
  [
    ["nintendo_3ds_game_card", 2.5],
    ["nintendo_ds_game_card", 2.5],
    ["nintendo_game_boy_cartridge_a_or_b", 4],
    ["nintendo_game_boy_cartridge_c", 4],
  ],
  dictionary_get(inlay, "type")
);
