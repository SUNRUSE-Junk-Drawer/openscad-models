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

module printed_fretboard_segment(fret_index) {
  start_y_mm = fret_y_mm(scale_length_mm, fret_index + 1) + fret_thickness_mm / 2 + fret_spacing_mm;
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

  end_y_mm = fret_y_mm(scale_length_mm, fret_index) - fret_thickness_mm / 2 - fret_spacing_mm;
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

  difference() {
    union() {
      loft(
        concat(
          [
            for (xz_mm = fretboard_segment_cross_section(
              fretboard_radius_mm,
              fretboard_sides,
              start_neck_width_mm,
              body_thickness_mm,
              false,
              fretboard_cutout_margin_sides,
              fretboard_cutout_shape,
              truss_rod_cutout_diameter_mm,
              fret_tang_cutout_height_mm
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
            for (xz_mm = fretboard_segment_cross_section(
              fretboard_radius_mm,
              fretboard_sides,
              end_neck_width_mm,
              body_thickness_mm,
              false,
              fretboard_cutout_margin_sides,
              fretboard_cutout_shape,
              truss_rod_cutout_diameter_mm,
              fret_tang_cutout_height_mm
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

      translate([fret_orienter_x_mm, end_y_mm, fret_orienter_z_mm]) {
        rotate([90, 0, 0]) {
          sphere(d = fret_orienter_diameter_mm, $fn = fret_orienter_sides);
        };
      };

      translate([-fret_orienter_x_mm, end_y_mm, fret_orienter_z_mm]) {
        rotate([90, 0, 0]) {
          sphere(d = fret_orienter_diameter_mm, $fn = fret_orienter_sides);
        };
      };
    };

    translate([
      0,
      truss_rod_y_mm() - truss_rod_length_mm() / 2,
      truss_rod_z_mm(
        truss_rod_cutout_diameter_mm,
        body_thickness_mm,
        fret_tang_cutout_height_mm
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

    translate([fret_orienter_x_mm, start_y_mm, fret_orienter_z_mm]) {
      rotate([90, 0, 0]) {
        sphere(d = fret_orienter_cutout_diameter_mm, $fn = fret_orienter_sides);
      };
    };

    translate([-fret_orienter_x_mm, start_y_mm, fret_orienter_z_mm]) {
      rotate([90, 0, 0]) {
        sphere(d = fret_orienter_cutout_diameter_mm, $fn = fret_orienter_sides);
      };
    };

    translate([fret_label_x_mm, start_y_mm + fret_label_depth_mm - 0.01, fret_label_z_mm]) {
      rotate([90, 0, 0]) {
        linear_extrude(fret_label_depth_mm + 0.01) {
          text(
            str(fret_index + 1),
            size = fret_label_size_mm,
            halign = "center",
            valign = "center",
            font = "Liberation Sans:style=Bold"
          );
        };
      };
    };

    translate([-fret_label_x_mm, start_y_mm + fret_label_depth_mm - 0.01, fret_label_z_mm]) {
      rotate([90, 0, 0]) {
        linear_extrude(fret_label_depth_mm + 0.01) {
          text(
            str(fret_index),
            size = fret_label_size_mm,
            halign = "center",
            valign = "center",
            font = "Liberation Sans:style=Bold"
          );
        };
      };
    };
  };
};
