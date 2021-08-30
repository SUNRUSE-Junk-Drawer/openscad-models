use <../utilities/dictionary_get.scad>;
use <utilities/inlay_embed_depth_mm.scad>;
use <utilities/inlay_protrusion_depth_mm.scad>;
use <utilities/settings.scad>;

module frame(settings) {
  glazing = dictionary_get(settings, "glazing");
  glazing_width_mm = dictionary_get(glazing, "width_mm");
  glazing_height_mm = dictionary_get(glazing, "height_mm");
  glazing_depth_mm = dictionary_get(glazing, "depth_mm");

  backing = dictionary_get(settings, "backing");
  backing_width_mm = dictionary_get(backing, "width_mm");
  backing_height_mm = dictionary_get(backing, "height_mm");
  backing_depth_mm = dictionary_get(backing, "depth_mm");

  border = dictionary_get(settings, "border");
  border_type = dictionary_get(border, "type");
  border_thickness_mm = dictionary_get(border, "thickness_mm");

  inlays = dictionary_get(settings, "inlays");

  greatest_inlay_embed_depth_mm = max([ for (inlay = inlays) inlay_embed_depth_mm(inlay) ]);
  greatest_inlay_protrusion_depth_mm = max([ for (inlay = inlays) inlay_protrusion_depth_mm(inlay) ]);

  inlay_width_mm = max(glazing_width_mm, backing_width_mm);
  width_mm = inlay_width_mm + border_thickness_mm * 2;
  inlay_height_mm = max(glazing_height_mm, backing_height_mm);
  height_mm = inlay_height_mm + border_thickness_mm * 2;
  depth_mm =
    backing_lip_depth_mm()
    + backing_depth_mm
    + inlay_bottom_depth_mm()
    + greatest_inlay_embed_depth_mm
    + greatest_inlay_protrusion_depth_mm
    + inlay_top_clearance_mm()
    + glazing_depth_mm
    + glazing_lip_depth_mm();

  difference() {
    if (border_type == "square") {
      translate([
        width_mm / -2,
        height_mm / -2,
        0,
      ]) {
        cube([
          width_mm,
          height_mm,
          depth_mm,
        ]);
      };
    } else if (border_type == "rounded_flat") {
      border_thickness_mm = dictionary_get(border, "thickness_mm");
      border_sides = dictionary_get(border, "sides");

      linear_extrude(depth_mm) {
        hull() {
          translate([
            width_mm / -2 + border_thickness_mm,
            height_mm / -2 + border_thickness_mm,
          ]) {
            circle(r = border_thickness_mm, $fn = border_sides);
          };

          translate([
            width_mm / 2 - border_thickness_mm,
            height_mm / -2 + border_thickness_mm,
          ]) {
            circle(r = border_thickness_mm, $fn = border_sides);
          };

          translate([
            width_mm / -2 + border_thickness_mm,
            height_mm / 2 - border_thickness_mm,
          ]) {
            circle(r = border_thickness_mm, $fn = border_sides);
          };

          translate([
            width_mm / 2 - border_thickness_mm,
            height_mm / 2 - border_thickness_mm,
          ]) {
            circle(r = border_thickness_mm, $fn = border_sides);
          };
        };
      };
    } else {
      assert(false, "Unexpected inlay type");
    };

    backing_apeture_width_mm = backing_width_mm - backing_lip_thickness_mm() * 2;
    backing_apeture_height_mm = backing_height_mm - backing_lip_thickness_mm() * 2;

    translate([
      backing_apeture_width_mm / -2,
      backing_apeture_height_mm / -2,
      0,
    ]) {
      cube([
        backing_apeture_width_mm,
        backing_apeture_height_mm,
        backing_lip_depth_mm() - backing_lip_slope_depth_mm(),
      ]);
    };

    hull() {
      translate([
        backing_apeture_width_mm / -2,
        backing_apeture_height_mm / -2,
        backing_lip_depth_mm() - backing_lip_slope_depth_mm(),
      ]) {
        cube([
          backing_apeture_width_mm,
          backing_apeture_height_mm,
          backing_lip_slope_depth_mm(),
        ]);
      };

      translate([
        backing_width_mm / -2,
        backing_height_mm / -2,
        backing_lip_depth_mm(),
      ]) {
        cube([
          backing_width_mm,
          backing_height_mm,
          backing_depth_mm,
        ]);
      };
    };

    translate([
      backing_width_mm / -2,
      backing_height_mm / -2,
      backing_lip_depth_mm(),
    ]) {
      cube([
        backing_width_mm,
        backing_height_mm,
        backing_depth_mm,
      ]);
    };

    translate([
      inlay_width_mm / -2,
      inlay_height_mm / -2,
      backing_lip_depth_mm() + backing_depth_mm,
    ]) {
      cube([
        backing_width_mm,
        backing_height_mm,
        inlay_bottom_depth_mm()
          + greatest_inlay_embed_depth_mm
          + greatest_inlay_protrusion_depth_mm
          + inlay_top_clearance_mm(),
      ]);
    };

    translate([
      glazing_width_mm / -2,
      glazing_height_mm / -2,
      depth_mm - glazing_lip_depth_mm() - glazing_depth_mm,
    ]) {
      cube([
        glazing_width_mm,
        glazing_height_mm,
        glazing_depth_mm,
      ]);
    };

    glazing_apeture_width_mm = glazing_width_mm - glazing_lip_thickness_mm() * 2;
    glazing_apeture_height_mm = glazing_height_mm - glazing_lip_thickness_mm() * 2;

    translate([
      glazing_apeture_width_mm / -2,
      glazing_apeture_height_mm / -2,
      depth_mm - glazing_lip_depth_mm(),
    ]) {
      cube([
        glazing_apeture_width_mm,
        glazing_apeture_height_mm,
        glazing_lip_depth_mm(),
      ]);
    };
  };
};
