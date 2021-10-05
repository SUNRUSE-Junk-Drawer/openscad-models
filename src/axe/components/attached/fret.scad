use <../../calculations/fret.scad>;
use <../../calculations/fretboard.scad>;
use <../../calculations/neck.scad>;
use <../../calculations/truss_rod.scad>;
use <../../../utilities/loft.scad>;
include <../../measurements/fret.scad>;
include <../../measurements/neck.scad>;
include <../../measurements/fretboard.scad>;
include <../../measurements/body.scad>;
include <../../measurements/truss_rod.scad>;

module attached_fret(fret_index) {
  y_mm = fret_y_mm(scale_length_mm, fret_index);

  head_start_y_mm = y_mm - fret_thickness_mm / 2;
  head_start_neck_width_mm = neck_interpolate(
    scale_length_mm,
    fret_count,
    neck_width_zero_mm,
    neck_width_body_mm,
    head_start_y_mm,
    1
  );

  head_end_y_mm = y_mm + fret_thickness_mm / 2;
  head_end_neck_width_mm = neck_interpolate(
    scale_length_mm,
    fret_count,
    neck_width_zero_mm,
    neck_width_body_mm,
    head_end_y_mm,
    1
  );

  tang_start_y_mm = y_mm - fret_tang_thickness_mm / 2;
  tang_start_neck_width_mm = neck_interpolate(
    scale_length_mm,
    fret_count,
    neck_width_zero_mm,
    neck_width_body_mm,
    tang_start_y_mm,
    1
  );

  tang_end_y_mm = y_mm + fret_tang_thickness_mm / 2;
  tang_end_neck_width_mm = neck_interpolate(
    scale_length_mm,
    fret_count,
    neck_width_zero_mm,
    neck_width_body_mm,
    tang_end_y_mm,
    1
  );

  loft([
    for (xz_mm = fret_head_cross_section(
      fretboard_radius_mm,
      fretboard_sides,
      head_start_neck_width_mm,
      body_thickness_mm,
      fret_height_mm
    )) [xz_mm[0], head_start_y_mm, xz_mm[1]]
  ], [
    for (xz_mm = fret_head_cross_section(
      fretboard_radius_mm,
      fretboard_sides,
      head_end_neck_width_mm,
      body_thickness_mm,
      fret_height_mm
    )) [xz_mm[0], head_end_y_mm, xz_mm[1]]
  ]);

  loft([
    for (xz_mm = fret_tang_cross_section(
      fretboard_radius_mm,
      fretboard_sides,
      tang_start_neck_width_mm,
      body_thickness_mm,
      fret_tang_height_mm,
      fret_tang_margin_mm
    )) [xz_mm[0], tang_start_y_mm, xz_mm[1]]
  ], [
    for (xz_mm = fret_tang_cross_section(
      fretboard_radius_mm,
      fretboard_sides,
      tang_end_neck_width_mm,
      body_thickness_mm,
      fret_tang_height_mm,
      fret_tang_margin_mm
    )) [xz_mm[0], tang_end_y_mm, xz_mm[1]]
  ]);
};
