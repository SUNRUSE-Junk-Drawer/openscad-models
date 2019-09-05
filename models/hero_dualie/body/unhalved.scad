include <../../settings.scad>;
use <../../utilities/cylinders.scad>;
include <measurements.scad>;
use <outer.scad>;
use <indent.scad>;
use <cutout.scad>;
include <../barrel/measurements.scad>;
use <../../connectors/notched_circle/male.scad>;

module hero_dualie_body_unhalved() {
  difference() {
    // Tail cutout.
    linear_extrude(hero_dualie_body_thickness, center = true) {
      difference() {
        hero_dualie_body_outer();
        hero_dualie_body_cutout();
      };
    }

    // Right indent.
    translate([
      0,
      0,
      hero_dualie_body_thickness / 2 - hero_dualie_body_indent_depth
    ]) {
      linear_extrude(hero_dualie_body_indent_depth) {
        hero_dualie_body_indent();
      };
    };

    // Left indent.
    translate([
      0,
      0,
      hero_dualie_body_thickness / -2
    ]) {
      linear_extrude(hero_dualie_body_indent_depth) {
        hero_dualie_body_indent();
      };
    };

    // A hole for the barrel.
    translate([
      hero_dualie_barrel_connector_length,
      hero_dualie_body_front_height / 2,
      0
    ]) {
      rotate([0, -90, 0]) {
        cylinder(
          d = hero_dualie_barrel_diameter + loose_tolerance,
          h = hero_dualie_barrel_connector_length,
          $fn = cylinder_sides(hero_dualie_barrel_diameter)
        );
      };
    };
  };

  // The connector to the barrel.
  translate([
    hero_dualie_barrel_connector_length,
    hero_dualie_body_front_height / 2,
    0
  ]) {
    rotate([0, -90, 0]) {
      connectors_notched_circle_male(
        hero_dualie_barrel_connector_diameter,
        hero_dualie_barrel_connector_length,
        hero_dualie_barrel_connector_notches
      );
    };
  };

  // The cap on the handle.
  intersection() {
    translate([
      hero_dualie_body_handle_x,
      hero_dualie_body_handle_y,
      0
    ]) {
      rotate([-90, 0, 0]) {
        cylinder(
          d = hero_dualie_body_handle_cap_diameter,
          h = hero_dualie_body_handle_cap_height,
          $fn = cylinder_sides(hero_dualie_body_handle_cap_diameter)
        );
      };
    };

    translate([
      hero_dualie_body_handle_x - hero_dualie_body_handle_length / 2,
      hero_dualie_body_handle_y,
      hero_dualie_body_handle_cap_diameter / -2
    ]) {
      cube([
        hero_dualie_body_handle_length,
        hero_dualie_body_handle_cap_height,
        hero_dualie_body_handle_cap_diameter
      ]);
    };
  };

  // The "blobs" above the handle.
  intersection() {
    translate([
      hero_dualie_body_handle_x - hero_dualie_body_handle_merger_width / 2,
      hero_dualie_body_handle_y - hero_dualie_body_handle_merger_height,
      -hero_dualie_body_handle_merger_z
    ]) {
      cube([
        hero_dualie_body_handle_merger_width,
        hero_dualie_body_handle_merger_height,
        hero_dualie_body_handle_merger_z * 2
      ]);
    };
    hull() {
      translate([
        hero_dualie_body_handle_x,
        hero_dualie_body_handle_y,
        hero_dualie_body_handle_merger_z - hero_dualie_body_handle_merger_thickness
      ]) {
        scale([
          hero_dualie_body_handle_merger_width / 2,
          hero_dualie_body_handle_merger_height,
          hero_dualie_body_handle_merger_thickness
        ]) {
          sphere(
            1,
            $fn = cylinder_sides(hero_dualie_body_handle_merger_height * 2)
          );
        };
      };
      translate([
        hero_dualie_body_handle_x,
        hero_dualie_body_handle_y,
        hero_dualie_body_handle_merger_thickness - hero_dualie_body_handle_merger_z
      ]) {
        scale([
          hero_dualie_body_handle_merger_width / 2,
          hero_dualie_body_handle_merger_height,
          hero_dualie_body_handle_merger_thickness
        ]) {
          sphere(
            1,
            $fn = cylinder_sides(hero_dualie_body_handle_merger_height * 2)
          );
        };
      };
    };
  };

  // The connector to the handle.
  translate([
    hero_dualie_body_handle_x,
    hero_dualie_body_handle_y + hero_dualie_body_handle_cap_height,
    0
  ]) {
    rotate([-90, 0, 0]) {
      connectors_notched_circle_male(
        hero_dualie_body_handle_connector_diameter,
        hero_dualie_body_handle_connector_length,
        hero_dualie_body_handle_connector_notches
      );
    };
  };
};
