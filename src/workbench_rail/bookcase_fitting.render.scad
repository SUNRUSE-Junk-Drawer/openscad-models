include <measurements.scad>;

// The thickness of the bookcase's wall, in millimeters.
bookcase_wall_thickness_mm = 18.5;

// The height of the clamp onto the bookcase's wall, in millimeters.
height_mm = 80;

// The length of the retainer for the tube, in millimeters.
tube_retainer_length_mm = 40;

// The length of the fingers which grip the bookcase's wall, in millimeters.
finger_length_mm = 60;

cube([
    outer_thickness_mm
        + bookcase_wall_thickness_mm
        + outer_thickness_mm,
    height_mm,
    outer_thickness_mm,
]);

difference() {
    rotate([
        0,
        angle - 90,
        0
    ]) {
        translate([
            tube_max_diameter_mm / 2 + outer_thickness_mm,
            height_mm / 2,
            0,
        ]) {
            difference() {
                cylinder(
                    d = tube_max_diameter_mm + outer_thickness_mm * 2,
                    h = tube_retainer_length_mm,
                    $fn = tube_sides
                );

                cylinder(
                    d1 = tube_max_diameter_mm,
                    d2 = tube_min_diameter_mm,
                    h = tube_diameter_transition_length_mm,
                    $fn = tube_sides
                );

                translate([
                    0,
                    0,
                    tube_diameter_transition_length_mm,
                ]) {
                    cylinder(
                        d = tube_min_diameter_mm,
                        h = tube_retainer_length_mm,
                        $fn = tube_sides
                    );
                };
            };
        };
    };

    translate([
        outer_thickness_mm,
        0,
        outer_thickness_mm,
    ]) {
        cube([
            bookcase_wall_thickness_mm,
            height_mm,
            finger_length_mm,
        ]);
    };
};

translate([
    0,
    0,
    outer_thickness_mm,
]) {
    cube([
        outer_thickness_mm,
        height_mm,
        finger_length_mm,
    ]);
};

translate([
    outer_thickness_mm
        + bookcase_wall_thickness_mm,
    0,
    outer_thickness_mm,
]) {
    cube([
        outer_thickness_mm,
        height_mm,
        finger_length_mm,
    ]);
};
