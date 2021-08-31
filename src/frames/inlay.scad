use <../utilities/dictionary_get.scad>;
use <inlays/nintendo_ds_game_card_inlay.scad>;
use <inlays/nintendo_game_boy_cartridge_a_or_b_inlay.scad>;
use <inlays/nintendo_game_boy_cartridge_c_inlay.scad>;
use <utilities/inlay_embed_depth_mm.scad>;
use <utilities/inlay_protrusion_depth_mm.scad>;
use <utilities/settings.scad>;

module inlay(settings) {
  glazing = dictionary_get(settings, "glazing");
  glazing_width_mm = dictionary_get(glazing, "width_mm");
  glazing_height_mm = dictionary_get(glazing, "height_mm");

  backing = dictionary_get(settings, "backing");
  backing_width_mm = dictionary_get(backing, "width_mm");
  backing_height_mm = dictionary_get(backing, "height_mm");
  backing_depth_mm = dictionary_get(backing, "depth_mm");

  inlays = dictionary_get(settings, "inlays");

  greatest_inlay_embed_depth_mm = max([ for (inlay = inlays) inlay_embed_depth_mm(inlay) ]);
  greatest_inlay_protrusion_depth_mm = max([ for (inlay = inlays) inlay_protrusion_depth_mm(inlay) ]);

  inlay_width_mm = max(glazing_width_mm, backing_width_mm) - inlay_side_tolerance_mm() * 2;
  inlay_height_mm = max(glazing_height_mm, backing_height_mm) - inlay_side_tolerance_mm() * 2;

  difference() {
    translate([
      inlay_width_mm / -2,
      inlay_height_mm / -2,
      backing_lip_depth_mm()
        + backing_depth_mm,
    ]) {
      cube([
        inlay_width_mm,
        inlay_height_mm,
        inlay_bottom_depth_mm()
          + greatest_inlay_embed_depth_mm
          + greatest_inlay_protrusion_depth_mm
          + inlay_top_clearance_mm(),
      ]);
    };

    translate([
      inlay_width_mm / -2 + glazing_lip_thickness_mm() - inlay_side_tolerance_mm(),
      inlay_height_mm / -2 + glazing_lip_thickness_mm() - inlay_side_tolerance_mm(),
      backing_lip_depth_mm()
        + backing_depth_mm
        + inlay_bottom_depth_mm()
        + greatest_inlay_embed_depth_mm,
    ]) {
      cube([
        inlay_width_mm - glazing_lip_thickness_mm() * 2 + inlay_side_tolerance_mm() * 2,
        inlay_height_mm - glazing_lip_thickness_mm() * 2 + inlay_side_tolerance_mm() * 2,
        greatest_inlay_protrusion_depth_mm + inlay_top_clearance_mm(),
      ]);
    };

    translate([
      0,
      0,
      backing_lip_depth_mm()
        + backing_depth_mm
        + inlay_bottom_depth_mm()
        + greatest_inlay_embed_depth_mm,
    ]) {
      for (inlay = inlays) {
        inlay_type = dictionary_get(inlay, "type");

        embed_depth_mm = inlay_embed_depth_mm(inlay);

        origin = dictionary_get(inlay, "origin");

        origin_x_mm = dictionary_get(origin, "x_mm");
        origin_y_mm = dictionary_get(origin, "y_mm");

        translate([
          origin_x_mm,
          origin_y_mm,
          0,
        ]) {
          if (inlay_type == "nintendo_game_boy_cartridge_a_or_b") {
            nintendo_game_boy_cartridge_a_or_b_inlay(settings, inlay, embed_depth_mm);
          } else if (inlay_type == "nintendo_game_boy_cartridge_c") {
            nintendo_game_boy_cartridge_c_inlay(settings, inlay, embed_depth_mm);
          } else if (inlay_type == "nintendo_ds_game_card") {
            translate([
              nintendo_ds_game_card_inlay_width_mm() / -2,
              nintendo_ds_game_card_inlay_height_mm() / -2,
              -embed_depth_mm,
            ]) {
              cube([
                nintendo_ds_game_card_inlay_width_mm(),
                nintendo_ds_game_card_inlay_height_mm(),
                embed_depth_mm,
              ]);
            };
          } else {
            assert(false, "Unexpected inlay type");
          };
        };
      };
    };
  };
};
