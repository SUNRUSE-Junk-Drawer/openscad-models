include <../../measurements/string.scad>;
include <../../measurements/fret.scad>;
include <../../measurements/fretboard.scad>;
include <../../measurements/body.scad>;
use <../../calculations/string.scad>;
use <../../calculations/fret.scad>;
use <../../../utilities/line_3d.scad>;

for (string_index = [0 : string_count - 1]) {
  zero_y_mm = fret_y_mm(scale_length_mm, 0);
  bridge_y_mm = fret_bridge_y_mm(scale_length_mm);

  line_3d(
    [
      string_x_mm(
        zero_y_mm,
        string_index,
        string_count,
        scale_length_mm,
        string_spread_zero_mm,
        string_spread_bridge_mm
      ),
      zero_y_mm,
      string_z_mm(
        zero_y_mm,
        string_index,
        string_count,
        scale_length_mm,
        string_spread_zero_mm,
        string_spread_bridge_mm,
        fretboard_radius_mm,
        fret_zero_and_bridge_offset_mm,
        fret_height_mm,
        string_diameter_mm,
        body_thickness_mm
      ),
    ],
    [
      string_x_mm(
        bridge_y_mm,
        string_index,
        string_count,
        scale_length_mm,
        string_spread_zero_mm,
        string_spread_bridge_mm
      ),
      bridge_y_mm,
      string_z_mm(
        bridge_y_mm,
        string_index,
        string_count,
        scale_length_mm,
        string_spread_zero_mm,
        string_spread_bridge_mm,
        fretboard_radius_mm,
        fret_zero_and_bridge_offset_mm,
        fret_height_mm,
        string_diameter_mm,
        body_thickness_mm
      ),
    ],
    string_diameter_mm,
    string_sides
  );
};
