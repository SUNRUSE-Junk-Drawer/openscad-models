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

module printed_fret(fret_index) {
  y_mm = fret_y_mm(scale_length_mm, fret_index);

  start_y_mm = y_mm - fret_thickness_mm / 2;
  start_neck_width_mm = neck_interpolate(
    scale_length_mm,
    fret_count,
    neck_width_zero_mm,
    neck_width_body_mm,
    start_y_mm,
    1
  );
  start_neck_thickness_mm = neck_interpolate(
    scale_length_mm,
    fret_count,
    neck_thickness_zero_mm,
    neck_thickness_body_mm,
    start_y_mm,
    1
  );
  start_neck_shape = neck_interpolate(
    scale_length_mm,
    fret_count,
    neck_shape_zero,
    neck_shape_body,
    start_y_mm,
    1
  );

  end_y_mm = y_mm + fret_thickness_mm / 2;
  end_neck_width_mm = neck_interpolate(
    scale_length_mm,
    fret_count,
    neck_width_zero_mm,
    neck_width_body_mm,
    end_y_mm,
    1
  );
  end_neck_thickness_mm = neck_interpolate(
    scale_length_mm,
    fret_count,
    neck_thickness_zero_mm,
    neck_thickness_body_mm,
    end_y_mm,
    1
  );
  end_neck_shape = neck_interpolate(
    scale_length_mm,
    fret_count,
    neck_shape_zero,
    neck_shape_body,
    end_y_mm,
    1
  );

  cutout_start_y_mm = y_mm - fret_tang_cutout_thickness_mm / 2;
  cutout_start_width_mm = neck_interpolate(
    scale_length_mm,
    fret_count,
    neck_width_zero_mm,
    neck_width_body_mm,
    cutout_start_y_mm,
    1
  );

  cutout_end_y_mm = y_mm + fret_tang_cutout_thickness_mm / 2;
  cutout_end_width_mm = neck_interpolate(
    scale_length_mm,
    fret_count,
    neck_width_zero_mm,
    neck_width_body_mm,
    cutout_end_y_mm,
    1
  );

  difference() {
    loft(
      concat(
        [
          for (xz_mm = fretboard_cross_section(
            fretboard_radius_mm,
            fretboard_sides,
            start_neck_width_mm,
            body_thickness_mm,
            false
          )) [xz_mm[0], start_y_mm, xz_mm[1]]
        ],
        [
          for (xz_mm = neck_cross_section(
            fretboard_radius_mm,
            body_thickness_mm,
            neck_sides,
            start_neck_width_mm,
            start_neck_thickness_mm,
            start_neck_shape
          )) [xz_mm[0], start_y_mm, xz_mm[1]]
        ]
      ),
      concat(
        [
          for (xz_mm = fretboard_cross_section(
            fretboard_radius_mm,
            fretboard_sides,
            end_neck_width_mm,
            body_thickness_mm,
            false
          )) [xz_mm[0], end_y_mm, xz_mm[1]]
        ],
        [
          for (xz_mm = neck_cross_section(
            fretboard_radius_mm,
            body_thickness_mm,
            neck_sides,
            end_neck_width_mm,
            end_neck_thickness_mm,
            end_neck_shape
          )) [xz_mm[0], end_y_mm, xz_mm[1]]
        ]
      )
    );

    loft([
      for (xz_mm = fret_cutout_cross_section(
        fretboard_radius_mm,
        fretboard_sides,
        cutout_start_width_mm,
        body_thickness_mm,
        fret_tang_cutout_height_mm,
        fret_tang_cutout_margin_mm
      )) [xz_mm[0], cutout_start_y_mm, xz_mm[1]]
    ], [
      for (xz_mm = fret_cutout_cross_section(
        fretboard_radius_mm,
        fretboard_sides,
        cutout_end_width_mm,
        body_thickness_mm,
        fret_tang_cutout_height_mm,
        fret_tang_cutout_margin_mm
      )) [xz_mm[0], cutout_end_y_mm, xz_mm[1]]
    ]);

    translate([
      0,
      truss_rod_y_mm() - truss_rod_length_mm() / 2,
      truss_rod_z_mm(
        truss_rod_cutout_diameter_mm,
        body_thickness_mm,
        fret_tang_height_mm
      ),
    ]) {
      rotate([-90, 0, 0]) {
        cylinder(
          d = truss_rod_cutout_diameter_mm,
          h = truss_rod_length_mm(),
          $fn = truss_rod_sides
        );
      };
    };
  };
};
