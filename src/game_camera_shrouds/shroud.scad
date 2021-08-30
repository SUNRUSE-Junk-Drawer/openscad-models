use <../utilities/dictionary_get.scad>;

/**
 * A "shroud" which fits onto a games console and suspends a camera over it.
 * @param settings An array representing a dictionary of settings for the
 *                 shroud, containing:
 *                 - camera
 *                   - distance_mm     - The distance between the screen and the
 *                                       camera, in millimeters.
 *                   - depth_mm        - The depth of the camera (along the axis
 *                                       of the camera's view).
 *                   - width_mm        - The width of the camera (parallel with
 *                                       the height of the console's screen).
 *                   - apeture
 *                     - inset_mm      - The distance between the top of the
 *                                       camera and its apeture, in millimeters.
 *                     - diameter_mm   - The diameter of the camera apeture, in
 *                                       millimeters.
 *                     - sides         - The number of sides of the camera
 *                                       apeture.
 *                 - console
 *                   - cartridge
 *                     - width_mm      - The distance between the supports under
 *                                       the console body, in millimeters.
 *                     - protrusion_mm - The length of the supports under the
 *                                       console body, in millimeters.
 *                     - depth_mm      - The thickness of the supports under the
 *                                       console body, in millimeters.
 *                   - body
 *                     - width_mm      - The width of the console body, in
 *                                       millimeters.
 *                     - depth_mm      - The depth of the console body, in
 *                                       millimeters.
 *                   - screen
 *                     - height_mm     - The height of the screen, in
 *                                       millimeters.
 *                 - wall_thickness_mm - The thickness of the walls of the
 *                                       shroud, in millimeters.
 *                 - led
 *                   - diameter_mm     - The diameter of the LEDs, in
 *                                       millimeters.
 *                   - sides           - The number of sides per LED.
 */
module shroud(settings) {
  camera = dictionary_get(settings, "camera");
  camera_distance_mm = dictionary_get(camera, "distance_mm");
  camera_depth_mm = dictionary_get(camera, "depth_mm");
  camera_width_mm = dictionary_get(camera, "width_mm");
  camera_apeture = dictionary_get(camera, "apeture");
  camera_apeture_inset_mm = dictionary_get(camera_apeture, "inset_mm");
  camera_apeture_diameter_mm = dictionary_get(camera_apeture, "diameter_mm");
  camera_apeture_sides = dictionary_get(camera_apeture, "sides");
  console = dictionary_get(settings, "console");
  console_cartridge = dictionary_get(console, "cartridge");
  console_cartridge_width_mm = dictionary_get(console_cartridge, "width_mm");
  console_cartridge_protrusion_mm = dictionary_get(console_cartridge, "protrusion_mm");
  console_cartridge_depth_mm = dictionary_get(console_cartridge, "depth_mm");
  console_body = dictionary_get(console, "body");
  console_body_width_mm = dictionary_get(console_body, "width_mm");
  console_body_depth_mm = dictionary_get(console_body, "depth_mm");
  console_screen = dictionary_get(console, "screen");
  console_screen_top_inset_mm = dictionary_get(console_screen, "top_inset_mm");
  console_screen_width_mm = dictionary_get(console_screen, "width_mm");
  console_screen_height_mm = dictionary_get(console_screen, "height_mm");
  wall_thickness_mm = dictionary_get(settings, "wall_thickness_mm");
  led = dictionary_get(settings, "led");
  led_diameter_mm = dictionary_get(led, "diameter_mm");
  led_sides = dictionary_get(led, "sides");

  base_width_mm = max(console_body_width_mm, camera_apeture_inset_mm * 2 + wall_thickness_mm * 2);
  cartridge_peg_width_mm = (console_body_width_mm - console_cartridge_width_mm) / 2;

  console_depth_offset_mm = max(0, (camera_width_mm / 2) - (console_screen_top_inset_mm + console_screen_height_mm / 2));
  camera_depth_offset_mm = max(0, (console_screen_top_inset_mm + console_screen_height_mm / 2) - (camera_width_mm / 2));

  // The wall which runs from behind the cartridge, up past the console body,
  // along the top of the screen and up to the camera retainer.
  translate([
    base_width_mm / 2 - console_body_width_mm / 2,
    0,
    0,
  ]) {
    cube([
      console_body_width_mm,
      console_cartridge_depth_mm
        + console_body_depth_mm
        + camera_distance_mm
        + wall_thickness_mm,
      console_depth_offset_mm + wall_thickness_mm,
    ]);
  };

  // The left cartridge retaining peg.
  translate([
    base_width_mm / 2 - console_body_width_mm / 2,
    0,
    console_depth_offset_mm + wall_thickness_mm,
  ]) {
    cube([
      cartridge_peg_width_mm,
      console_cartridge_depth_mm,
      console_cartridge_protrusion_mm + wall_thickness_mm,
    ]);
  };

  // The right cartridge retaining peg.
  translate([
    base_width_mm / 2 + console_body_width_mm / 2 - cartridge_peg_width_mm,
    0,
    console_depth_offset_mm + wall_thickness_mm,
  ]) {
    cube([
      cartridge_peg_width_mm,
      console_cartridge_depth_mm,
      console_cartridge_protrusion_mm,
    ]);
  };

  // The block which sits above the screen.
  translate([
    (base_width_mm - console_screen_width_mm) / 2,
    console_cartridge_depth_mm + console_body_depth_mm,
    console_depth_offset_mm + wall_thickness_mm,
  ]) {
    cube([
      console_screen_width_mm,
      camera_distance_mm,
      console_screen_top_inset_mm,
    ]);
  };

  difference() {
    // The left wall.
    translate([
      (base_width_mm - console_body_width_mm) / 2,
      console_cartridge_depth_mm + console_body_depth_mm,
      console_depth_offset_mm + wall_thickness_mm,
    ]) {
      cube([
        (console_body_width_mm - console_screen_width_mm) / 2,
        camera_distance_mm,
        max(console_screen_top_inset_mm + console_screen_height_mm, camera_width_mm - console_depth_offset_mm) + wall_thickness_mm,
      ]);
    };

    // The cutout for the left LED.
    translate([
      base_width_mm / 2,
      console_cartridge_depth_mm + console_body_depth_mm,
      console_screen_top_inset_mm
        + led_diameter_mm / 2
        + (console_screen_height_mm - led_diameter_mm / 2) / 3
    ]) {
      rotate([-90, 0, 45]) {
        cylinder(d = led_diameter_mm, h = 10000, $fn = led_sides);
      };
    };
  };

  difference() {
    // The right wall.
    translate([
      (base_width_mm + console_body_width_mm) / 2 - (console_body_width_mm - console_screen_width_mm) / 2,
      console_cartridge_depth_mm + console_body_depth_mm,
      console_depth_offset_mm + wall_thickness_mm,
    ]) {
      cube([
        (console_body_width_mm - console_screen_width_mm) / 2,
        camera_distance_mm,
        max(console_screen_top_inset_mm + console_screen_height_mm, camera_width_mm - console_depth_offset_mm) + wall_thickness_mm,
      ]);
    };

    // The cutout for the right LED.
    translate([
      base_width_mm / 2,
      console_cartridge_depth_mm + console_body_depth_mm,
      console_screen_top_inset_mm
        + led_diameter_mm / 2
        + (console_screen_height_mm - led_diameter_mm / 2) / 3
    ]) {
      rotate([-90, 0, -45]) {
        cylinder(d = led_diameter_mm, h = 10000, $fn = led_sides);
      };
    };
  };

  difference() {
    // The lower retainer for the camera.
    translate([
      0,
      console_cartridge_depth_mm
        + console_body_depth_mm
        + camera_distance_mm,
      wall_thickness_mm,
    ]) {
      cube([
        base_width_mm,
        wall_thickness_mm,
        max(camera_width_mm, console_screen_top_inset_mm + console_screen_height_mm) + wall_thickness_mm,
      ]);
    };

    // The apeture for the camera.
    translate([
      base_width_mm / 2,
      console_cartridge_depth_mm
        + console_body_depth_mm
        + camera_distance_mm,
      wall_thickness_mm + max(console_screen_top_inset_mm + console_screen_height_mm, camera_width_mm) / 2,
    ]) {
      rotate([-90, 0, 0]) {
        cylinder(
          d = camera_apeture_diameter_mm,
          h = wall_thickness_mm,
          $fn = camera_apeture_sides
        );
      }
    };
  };

  // The upper retainer for the camera.
  translate([
    base_width_mm / 2 - camera_apeture_inset_mm - wall_thickness_mm,
    console_cartridge_depth_mm
      + console_body_depth_mm
      + camera_distance_mm
      + camera_depth_mm
      + wall_thickness_mm,
    wall_thickness_mm + camera_depth_offset_mm,
  ]) {
    cube([
      camera_apeture_inset_mm + wall_thickness_mm + base_width_mm / 2,
      wall_thickness_mm,
      camera_width_mm,
    ]);
  };

  // The left retainer for the camera.
  translate([
    base_width_mm / 2 - camera_apeture_inset_mm - wall_thickness_mm,
    console_cartridge_depth_mm
      + console_body_depth_mm
      + camera_distance_mm + wall_thickness_mm,
    wall_thickness_mm + camera_depth_offset_mm,
  ]) {
    cube([
      wall_thickness_mm,
      camera_depth_mm,
      camera_width_mm,
    ]);
  };

  // The far retainer for the camera.
  translate([
    base_width_mm / 2 - camera_apeture_inset_mm - wall_thickness_mm,
    console_cartridge_depth_mm
      + console_body_depth_mm
      + camera_distance_mm,
    0,
  ]) {
    cube([
      camera_apeture_inset_mm + wall_thickness_mm + base_width_mm / 2,
      camera_depth_mm + wall_thickness_mm * 2,
      camera_depth_offset_mm + wall_thickness_mm,
    ]);
  };

  // The near retainer for the camera.
  translate([
    base_width_mm / 2 - camera_apeture_inset_mm - wall_thickness_mm,
    console_cartridge_depth_mm
      + console_body_depth_mm
      + camera_distance_mm,
    camera_depth_offset_mm + wall_thickness_mm + camera_width_mm,
  ]) {
    cube([
      camera_apeture_inset_mm + wall_thickness_mm + base_width_mm / 2,
      camera_depth_mm + wall_thickness_mm * 2,
      wall_thickness_mm,
    ]);
  };
};
